# frozen_string_literal: true

# Sincronización híbrida del carrito (plan Sección 4.1).
# Ejecutado al iniciar sesión: recibe los ítems almacenados en localStorage
# del frontend y los fusiona con el carrito persistido en base de datos.
#
# Reglas de fusión:
#   - Si el producto ya existe en BD → sumar cantidades (sin exceder stock).
#   - Si no existe → crear el registro CartItem.
#   - Todo en una única transacción para garantizar atomicidad.
class CartMergeService
  def initialize(user, local_items)
    @user = user
    @local_items = local_items || []
  end

  # Ejecuta la fusión del carrito.
  #
  # @return [Cart] el carrito actualizado con los ítems fusionados
  def call
    return fetch_or_create_cart if @local_items.empty?

    ActiveRecord::Base.transaction do
      cart = fetch_or_create_cart

      @local_items.each do |local_item|
        merge_item(cart, local_item)
      end

      cart.reload
    end
  end

  private

  def fetch_or_create_cart
    @user.cart || @user.create_cart!
  end

  # Fusiona un único ítem local con el carrito en base de datos.
  #
  # @param cart [Cart] carrito persistido
  # @param local_item [Hash] { product_id: UUID, quantity: Integer }
  def merge_item(cart, local_item)
    product = Product.find_by(id: local_item[:product_id], deleted_at: nil)
    return unless product

    cart_item = cart.cart_items.find_or_initialize_by(product: product)
    new_quantity = (cart_item.quantity || 0) + local_item[:quantity].to_i

    # Limitar a stock disponible para evitar cantidades imposibles
    cart_item.quantity = [new_quantity, product.stock].min
    cart_item.save!
  end
end
