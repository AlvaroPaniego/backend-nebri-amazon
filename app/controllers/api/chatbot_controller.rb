# frozen_string_literal: true

# Controlador del chatbot de asistencia pasiva (plan Sección 7).
# Permite consultas anónimas y de usuarios registrados.
class Api::ChatbotController < ApplicationController
  # POST /api/chatbot
  def process_message
    message = params[:message]

    if message.blank?
      return render json: { error: 'BadRequest', message: 'El mensaje no puede estar vacío' }, status: :bad_request
    end

    reply = ChatbotAssistantService.call(message, current_user: @current_user)
    render json: { reply: reply }
  end
end
