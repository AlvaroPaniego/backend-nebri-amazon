# frozen_string_literal: true

class ProductService
  PRODUCT_FIELDS = %i[id name description price stock sku image_urls].freeze

  def list
    Product.where(deleted_at: nil).select(*PRODUCT_FIELDS)
  end

  def find(id)
    Product.find_by!(id: id, deleted_at: nil)
  end

  def create(params)
    product = Product.new(params)
    product.save!
    product.slice(*PRODUCT_FIELDS)
  end

  def update(product, params)
    product.update!(params)
    product.slice(*PRODUCT_FIELDS)
  end

  def destroy(product)
    product.update!(deleted_at: Time.current)
    { message: 'Producto eliminado correctamente' }
  end
end
