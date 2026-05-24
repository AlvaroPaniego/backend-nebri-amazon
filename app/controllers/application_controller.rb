# frozen_string_literal: true

# Controlador base de la API (plan Sección 6.2).
# Proporciona la infraestructura de autenticación JWT y autorización RBAC
# que heredan todos los controladores del namespace Api::.
class ApplicationController < ActionController::API
  attr_reader :current_user

  protected

  # Verifica que la petición contenga un token JWT válido y carga @current_user.
  # Responde con 401 Unauthorized si el token es inválido o ausente.
  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header.present?

    if token.present?
      decoded = JsonWebToken.decode(token)
      if decoded.present?
        @current_user = User.find_by(id: decoded[:user_id])
        return if @current_user.present?
      end
    end

    render json: { error: 'Unauthenticated', message: 'Debe iniciar sesión para continuar' }, status: :unauthorized
  end

  # Valida que el usuario autenticado posea el rol de administrador.
  # Responde con 403 Forbidden si no tiene privilegios.
  def authorize_admin!
    authenticate_user! unless @current_user.present?

    if @current_user.present? && @current_user.role != 'admin'
      render json: { error: 'Unauthorized', message: 'No tiene privilegios de administrador' }, status: :forbidden
    end
  end
end
