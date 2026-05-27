# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :authenticate_user!

  # GET /api/cart
  def show
    render json: CartService.new(current_user).show
  end

  # DELETE /api/cart
  def destroy
    render json: CartService.new(current_user).clear
  end

  # POST /api/cart/sync
  def sync
    # Expects items to be in params[:items]
    render json: CartService.new(current_user).sync(params[:items])
  end
end
