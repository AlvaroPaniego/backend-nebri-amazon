# frozen_string_literal: true

class CartItemService
  class CartItemError < StandardError; end
  class NotFoundError < StandardError; end

  def initialize(cart)
    @cart = cart
  end

  def create(params)
    product = Product.find_by(id: params[:product_id], deleted_at: nil)
    raise NotFoundError, 'Producto no encontrado' unless product

    cart_item = @cart.cart_items.find_or_initialize_by(product: product)
    cart_item.quantity = (cart_item.quantity || 0) + params[:quantity].to_i

    if cart_item.save
      cart_item_payload(cart_item)
    else
      raise CartItemError, cart_item.errors.full_messages.join(', ')
    end
  end

  def update(id, params)
    cart_item = @cart.cart_items.find(id)
    if cart_item.update(params.slice(:quantity))
      cart_item_payload(cart_item)
    else
      raise CartItemError, cart_item.errors.full_messages.join(', ')
    end
  end

  def destroy(id)
    cart_item = @cart.cart_items.find(id)
    cart_item.destroy
    { message: 'Artículo removido del carrito' }
  end

  private

  def cart_item_payload(cart_item)
    {
      id: cart_item.id,
      quantity: cart_item.quantity,
      product_id: cart_item.product_id
    }
  end
end
