# frozen_string_literal: true

class Api::CartsController < ApplicationController
  before_action :authenticate_user!

  # GET /api/cart
  def show
    render json: CartService.new(current_user).show
  end
end
