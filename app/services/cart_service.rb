# frozen_string_literal: true

class CartService
  def initialize(user)
    @user = user
  end

  def show
    cart = @user.cart || @user.create_cart!
    cart_payload(cart)
  end

  def clear
    cart = @user.cart
    cart&.cart_items&.destroy_all
    { message: 'Cart cleared successfully' }
  end

  def sync(items_payload)
    cart = @user.cart || @user.create_cart!

    ActiveRecord::Base.transaction do
      Array(items_payload).each do |item_data|
        product_id = item_data.dig('product', 'id') || item_data['product_id']
        quantity = item_data['quantity'].to_i
        
        next unless product_id && quantity > 0
        
        cart_item = cart.cart_items.find_or_initialize_by(product_id: product_id)
        cart_item.quantity = [cart_item.quantity.to_i, quantity].max
        cart_item.save!
      end
    end

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
