# frozen_string_literal: true

class CategoryService
  CATEGORY_FIELDS = %i[id name].freeze

  def list
    Category.select(*CATEGORY_FIELDS).order(:name)
  end

  def find(id)
    Category.find(id)
  rescue ActiveRecord::RecordNotFound
    raise ActiveRecord::RecordNotFound, "Categoría no encontrada"
  end
end
