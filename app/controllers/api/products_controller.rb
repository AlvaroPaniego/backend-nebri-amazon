class Api::ProductsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorize_admin!, only: [:create, :update, :destroy]
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /api/products
  def index
    render json: ProductService.new.list(filter_params)
  end

  # GET /api/products/:id
  def show
    render json: ProductService.new.find(params[:id]).slice(*ProductService::PRODUCT_FIELDS)
  end

  # POST /api/products (admin only)
  def create
    product = ProductService.new.create(product_params)
    render json: product, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'ValidationError', message: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # PUT /api/products/:id (admin only)
  def update
    product = ProductService.new.update(@product, product_params)
    render json: product
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'ValidationError', message: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # DELETE /api/products/:id (admin only) – soft delete
  def destroy
    render json: ProductService.new.destroy(@product)
  end

  private

  def set_product
    @product = ProductService.new.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'NotFound', message: 'Producto no encontrado' }, status: :not_found
  end

  def filter_params
    params.permit(:category_id, :search)
  end
end
