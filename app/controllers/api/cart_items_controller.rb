# frozen_string_literal: true

class Api::CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  # POST /api/cart/items
  def create
    payload = CartItemService.new(@cart).create(item_params)
    render json: payload, status: :created
  rescue CartItemService::NotFoundError => e
    render json: { error: 'NotFound', message: e.message }, status: :not_found
  rescue CartItemService::CartItemError => e
    render json: { error: 'ValidationError', message: e.message }, status: :unprocessable_entity
  end

  # PUT /api/cart/items/:id
  def update
    payload = CartItemService.new(@cart).update(params[:id], item_params)
    render json: payload
  rescue CartItemService::CartItemError => e
    render json: { error: 'ValidationError', message: e.message }, status: :unprocessable_entity
  end

  # DELETE /api/cart/items/:id
  def destroy
    result = CartItemService.new(@cart).destroy(params[:id])
    render json: result
  end

  private

  def set_cart
    @cart = current_user.cart || current_user.create_cart!
  end

  def item_params
    params.permit(:product_id, :quantity)
  end
end
