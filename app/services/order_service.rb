# frozen_string_literal: true

class OrderService
  def initialize(user)
    @user = user
  end

  def list
    @user.orders
          .order(created_at: :desc)
          .includes(order_items: :product)
          .map do |order|
      {
        id: order.id,
        status: order.status,
        total_price: order.total_price,
        created_at: order.created_at,
        items: order.order_items.map do |oi|
          {
            product_id: oi.product_id,
            quantity: oi.quantity,
            price_snapshot: oi.price_snapshot,
            product: {
              name: oi.product.name,
              sku: oi.product.sku,
              image_url: oi.product.image_urls&.first
            }
          }
        end
      }
    end
  end

  def find(id)
    order = @user.orders.find_by(id: id)
    raise ActiveRecord::RecordNotFound, 'Orden no encontrada' unless order
    order
  end

  def self.summary_payload(order)
    { id: order.id, status: order.status, total_price: order.total_price, tracking_code: order.tracking_code }
  end

  def self.detail_payload(order)
    {
      id: order.id,
      status: order.status,
      total_price: order.total_price,
      items: order.order_items.includes(:product).map do |oi|
        {
          product_id: oi.product_id,
          quantity: oi.quantity,
          price_snapshot: oi.price_snapshot,
          product: {
            name: oi.product.name,
            sku: oi.product.sku,
            image_url: oi.product.image_urls&.first
          }
        }
      end
    }
  end
end
