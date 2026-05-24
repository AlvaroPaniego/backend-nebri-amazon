# frozen_string_literal: true

class AuthenticationService
  # Registers a new user and returns a payload with JWT token and user data
  def self.register(user_params)
    user = User.new(user_params)
    raise ActiveRecord::RecordInvalid, user if user.invalid?
    user.save!
    auth_payload(user)
  end

  # Authenticates a user and returns the same payload
  def self.login(email, password)
    user = User.find_by(email: email.to_s.downcase)
    raise AuthenticationError, 'Credenciales inválidas' unless user&.authenticate(password)
    auth_payload(user)
  end

  private_class_method def self.auth_payload(user)
    token = JsonWebToken.encode(user_id: user.id, role: user.role)
    { token: token, user: user.slice(:id, :name, :email, :role) }
  end

  class AuthenticationError < StandardError; end
end
