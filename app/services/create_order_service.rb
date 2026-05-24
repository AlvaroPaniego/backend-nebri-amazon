# frozen_string_literal: true

# Servicio transaccional que consolida una orden de compra a partir del carrito
# del usuario. Implementa el flujo completo definido en el plan (Sección 5.2):
#
#   1. Validar carrito no vacío
#   2. Decrementar stock con bloqueo pesimista (StockManagementService)
#   3. Calcular montos y crear snapshot de precios
#   4. Persistir la orden y sus líneas de pedido
#   5. Vaciar el carrito
#
# Todo dentro de una única transacción SQL — si falla cualquier paso,
# se ejecuta rollback automático.
class CreateOrderService
  def initialize(user)
    @user = user
  end

  # Ejecuta la creación de la orden.
  #
  # @return [Order] la orden creada
  # @raise [StandardError] si el carrito está vacío
  # @raise [StockManagementService::InsufficientStockError] si no hay stock suficiente
  def call
    ActiveRecord::Base.transaction do
      cart = @user.cart
      validate_cart!(cart)

      total_price = 0
      order_items_data = []

      cart.cart_items.includes(:product).each do |item|
        product = item.product

        StockManagementService.decrement_stock!(product.id, item.quantity)

        item_total = product.price * item.quantity
        total_price += item_total

        order_items_data << {
          product_id: product.id,
          quantity: item.quantity,
          price_snapshot: product.price
        }
      end

      order = @user.orders.create!(
        status: 'pending',
        total_price: total_price
      )

      order_items_data.each do |data|
        order.order_items.create!(data)
      end

      cart.cart_items.destroy_all

      order
    end
  end

  private

  def validate_cart!(cart)
    raise StandardError, 'El carrito está vacío' if cart.nil? || cart.cart_items.empty?
  end
end
