# frozen_string_literal: true

class ProductService
  PRODUCT_FIELDS = %i[id name description price stock sku image_urls].freeze

  def list(filters = {})
    products = Product.where(deleted_at: nil)

    if filters[:category_id].present?
      products = products.where(category_id: filters[:category_id])
    end

    if filters[:search].present?
      query = "%#{filters[:search]}%"
      products = products.where(
        'name ILIKE :q OR description ILIKE :q OR sku ILIKE :q',
        q: query
      )
    end

    products.select(*PRODUCT_FIELDS)
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
