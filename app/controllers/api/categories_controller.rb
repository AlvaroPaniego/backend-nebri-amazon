# frozen_string_literal: true

class Api::CategoriesController < ApplicationController
  # GET /api/categories
  def index
    render json: CategoryService.new.list
  end

  # GET /api/categories/:id
  def show
    render json: CategoryService.new.find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { error: 'NotFound', message: e.message }, status: :not_found
  end
end
