# frozen_string_literal: true

class CartService
  def initialize(user)
    @user = user
  end

  def show
    cart = @user.cart || @user.create_cart!
    cart_payload(cart)
  end

  private

  def cart_payload(cart)
    {
      id: cart.id,
      items: cart.cart_items.includes(:product).map do |item|
        {
          id: item.id,
          quantity: item.quantity,
          product: {
            id: item.product.id,
            name: item.product.name,
            price: item.product.price,
            sku: item.product.sku,
            image_urls: item.product.image_urls
          }
        }
      end
    }
  end
end
