# frozen_string_literal: true

# Servicio de asistencia por chatbot (plan Sección 7).
# Procesa consultas de texto del usuario y responde con información
# contextual sobre productos, estado de pedidos o políticas generales.
#
# Arquitectura pasiva: no inicia conversaciones, solo responde.
class ChatbotAssistantService
  GREETING_PATTERNS = /\b(hola|hi|hello|buenas|hey)\b/i.freeze
  ORDER_PATTERNS    = /\b(pedido|orden|order|envío|estado)\b/i.freeze
  PRODUCT_PATTERNS  = /\b(producto|artículo|stock|precio|disponible|buscar)\b/i.freeze
  HELP_PATTERNS     = /\b(ayuda|help|soporte|devolución|política)\b/i.freeze

  # Punto de entrada principal.
  #
  # @param message [String] mensaje del usuario
  # @param current_user [User, nil] usuario autenticado (puede ser nil)
  # @return [String] respuesta del chatbot
  def self.call(message, current_user: nil)
    new(message, current_user).process
  end

  def initialize(message, current_user)
    @message = message.to_s.strip
    @current_user = current_user
  end

  def process
    return greeting_response   if greeting?
    return order_response      if order_inquiry?
    return product_response    if product_inquiry?
    return help_response       if help_inquiry?

    default_response
  end

  private

  def greeting?
    @message.match?(GREETING_PATTERNS)
  end

  def order_inquiry?
    @message.match?(ORDER_PATTERNS)
  end

  def product_inquiry?
    @message.match?(PRODUCT_PATTERNS)
  end

  def help_inquiry?
    @message.match?(HELP_PATTERNS)
  end

  def greeting_response
    '¡Hola! Soy el asistente virtual de NebriAmazon. ¿En qué puedo ayudarte? ' \
      'Puedo informarte sobre productos, el estado de tus pedidos o nuestras políticas.'
  end

  def order_response
    return 'Para consultar el estado de tus pedidos, primero debes iniciar sesión.' unless @current_user

    orders = @current_user.orders.order(created_at: :desc).limit(3)
    return 'No tienes pedidos registrados aún.' if orders.empty?

    summary = orders.map do |order|
      "- Pedido ##{order.id[0..7]}... | Estado: #{order.status} | Total: $#{order.total_price}"
    end.join("\n")

    "Estos son tus últimos pedidos:\n#{summary}"
  end

  def product_response
    products = Product.where(deleted_at: nil).limit(5).select(:name, :price, :stock)
    return 'No hay productos disponibles en este momento.' if products.empty?

    listing = products.map do |product|
      "- #{product.name}: $#{product.price} (#{product.stock} en stock)"
    end.join("\n")

    "Aquí tienes algunos productos disponibles:\n#{listing}\n\n" \
      'Puedes ver el catálogo completo en nuestra tienda.'
  end

  def help_response
    'Nuestras políticas principales:' \
      "\n- Devoluciones: Aceptamos devoluciones dentro de los 30 días posteriores a la compra." \
      "\n- Envíos: Los envíos estándar tardan entre 3-5 días hábiles." \
      "\n- Soporte: Puedes contactarnos a través de este chat en cualquier momento." \
      "\n\n¿Hay algo más en lo que pueda ayudarte?"
  end

  def default_response
    'No estoy seguro de cómo ayudarte con eso. Puedo informarte sobre:' \
      "\n- 📦 Estado de tus pedidos" \
      "\n- 🛍️ Productos disponibles" \
      "\n- ❓ Políticas de devolución y envío" \
      "\n\n¿Sobre qué tema te gustaría saber más?"
  end
end
