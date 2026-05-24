# frozen_string_literal: true

class Api::OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show]

  # POST /api/orders – delega la creación al CreateOrderService
  def create
    order = CreateOrderService.new(current_user).call
    render json: OrderService.summary_payload(order), status: :created
  rescue StockManagementService::InsufficientStockError => e
    render json: { error: 'InsufficientStock', message: e.message }, status: :unprocessable_entity
  rescue StandardError => e
    render json: { error: 'BadRequest', message: e.message }, status: :bad_request
  end

  # GET /api/orders – lista de órdenes del usuario
  def index
    render json: OrderService.new(current_user).list
  end

  # GET /api/orders/:id – detalle de una orden
  def show
    render json: OrderService.detail_payload(@order)
  end

  private

  def set_order
    @order = OrderService.new(current_user).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: 'NotFound', message: e.message }, status: :not_found
  end
end
