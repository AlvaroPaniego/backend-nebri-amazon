# frozen_string_literal: true

# Servicio de gestión de stock con bloqueo pesimista (SELECT FOR UPDATE).
# Garantiza la integridad transaccional y previene condiciones de carrera
# (race conditions) que causarían overselling.
#
# Debe invocarse siempre dentro de un bloque ActiveRecord::Base.transaction.
class StockManagementService
  class InsufficientStockError < StandardError; end

  # Decrementa el stock de un producto de forma atómica.
  # Bloquea la fila con FOR UPDATE para evitar lecturas sucias concurrentes.
  #
  # @param product_id [String] UUID del producto
  # @param requested_quantity [Integer] cantidad solicitada
  # @raise [InsufficientStockError] si el stock es insuficiente o el producto fue eliminado
  def self.decrement_stock!(product_id, requested_quantity)
    product = Product.lock('FOR UPDATE').find(product_id)

    if product.deleted_at.present?
      raise InsufficientStockError, "El producto #{product.name} ya no está disponible."
    end

    if product.stock < requested_quantity
      raise InsufficientStockError,
            "Stock insuficiente para #{product.name}. Disponible: #{product.stock}, Solicitado: #{requested_quantity}"
    end

    product.decrement!(:stock, requested_quantity)
  end
end
