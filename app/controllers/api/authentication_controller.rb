# frozen_string_literal: true

class Api::AuthenticationController < ApplicationController
  # POST /api/auth/register
  def register
    payload = AuthenticationService.register(register_params)
    render json: payload, status: :created
  rescue ActiveRecord::RecordInvalid => e
    render json: { error: 'ValidationError', message: e.record.errors.full_messages }, status: :unprocessable_entity
  end

  # POST /api/auth/login
  def login
    payload = AuthenticationService.login(login_params[:email], login_params[:password])
    render json: payload
  rescue AuthenticationService::AuthenticationError => e
    render json: { error: 'AuthenticationError', message: e.message }, status: :unauthorized
  end

  # GET /api/auth/me
  def me
    if current_user
      render json: current_user.slice(:id, :name, :email, :role)
    else
      render json: { error: 'Unauthenticated', message: 'Debe iniciar sesión' }, status: :unauthorized
    end
  end

  private

  def register_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end

  def login_params
    params.permit(:email, :password)
  end

end
