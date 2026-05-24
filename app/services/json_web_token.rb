# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = ENV.fetch('JWT_SECRET') { Rails.application.credentials.secret_key_base || 'fallback_secret_key' }.freeze

  # Codifica un payload en un token JWT firmado con HS256
  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decodifica un token JWT y devuelve el payload como HashWithIndifferentAccess.
  # Retorna nil si el token es inválido o ha expirado.
  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' })[0]
    HashWithIndifferentAccess.new(decoded)
  rescue JWT::DecodeError
    nil
  end
end
