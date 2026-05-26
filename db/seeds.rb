# ─── Categories ───────────────────────────────────────────────────
categories_data = ['Electrónica', 'Hogar y Cocina', 'Libros', 'Deportes']
categories_data.each { |name| Category.find_or_create_by!(name: name) }

puts "Creadas #{Category.count} categorías: #{Category.pluck(:name).join(', ')}"

# ─── Products ─────────────────────────────────────────────────────
products_data = [
  # ── Electrónica (category_id: 1) ──
  {
    name: 'Auriculares Inalámbricos Premium ANC',
    description: 'Auriculares circumaurales inalámbricos premium con tecnología ANC híbrida, controladores dinámicos de 40 mm, autonomía de hasta 35 horas y carga ultra rápida por USB-C.',
    price: 129.99, stock: 24, sku: 'ELEC-ANC-001', category_id: 1,
    image_urls: ['https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Teclado Mecánico RGB NebriType Pro',
    description: 'Teclado mecánico para gaming y programación al 75% con interruptores hot-swappable, retroiluminación RGB direccionable, chasis de aluminio y doble espuma amortiguadora.',
    price: 89.50, stock: 15, sku: 'ELEC-KB-002', category_id: 1,
    image_urls: ['https://images.unsplash.com/photo-1618384887929-16ec33fab9ef?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Monitor 4K UHD 27\" NebriView',
    description: 'Monitor IPS de 27 pulgadas con resolución 4K UHD, tasa de refresco de 144 Hz, soporte HDR10, puertos USB-C con carga de 65W y altavoces estéreo integrados.',
    price: 399.00, stock: 10, sku: 'ELEC-MON-003', category_id: 1,
    image_urls: ['https://images.unsplash.com/photo-1527443224154-c4a3942d3acf?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Ratón Ergonómico Vertical NebriClick',
    description: 'Ratón vertical inalámbrico con sensor óptico de 4000 DPI ajustable, diseño ergonómico para prevenir lesiones por esfuerzo repetitivo, batería recargable de 80 horas y 6 botones programables.',
    price: 49.95, stock: 30, sku: 'ELEC-MOU-004', category_id: 1,
    image_urls: ['https://images.unsplash.com/photo-1527864550417-7fd91fc51a46?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Altavoz Portátil Resistente IP67',
    description: 'Altavoz Bluetooth 5.3 portátil con resistencia IP67 al agua y polvo. Potencia de 30W, batería de 20 horas, emparejamiento estéreo dual y micrófono integrado para llamadas.',
    price: 69.99, stock: 20, sku: 'ELEC-SPK-005', category_id: 1,
    image_urls: ['https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=800&auto=format&fit=crop&q=80']
  },

  # ── Hogar y Cocina (category_id: 2) ──
  {
    name: 'Cafetera Superautomática Italiana',
    description: 'Cafetera espresso superautomática con molinillo cónico de acero inoxidable integrado (13 ajustes), panel táctil, sistema de vaporización profesional y depósito de agua extraíble de 2L.',
    price: 499.00, stock: 8, sku: 'HOG-CAF-001', category_id: 2,
    image_urls: ['https://images.unsplash.com/photo-1517256064527-09c53b2d0c6b?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Robot Aspirador Láser 3D',
    description: 'Robot aspirador con navegación LiDAR 3D, succión de 4000 Pa, mopa vibratoria integrada, compatibilidad con Alexa/Google Home y depósito de autovaciado inteligente.',
    price: 349.00, stock: 12, sku: 'HOG-ASP-002', category_id: 2,
    image_urls: ['https://images.unsplash.com/photo-1589301760014-d929f3979dbc?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Set Cuchillos Profesionales 8 Piezas',
    description: 'Juego de cuchillos de cocina profesionales forjados en una sola pieza de acero inoxidable al carbono. Incluye bloque magnético de madera, tijeras y afilador integrado.',
    price: 89.99, stock: 18, sku: 'HOG-CUC-003', category_id: 2,
    image_urls: ['https://images.unsplash.com/photo-1593618998160-3405e56da7b5?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Freidora de Aire Digital 7L',
    description: 'Freidora de aire de 7 litros con 12 programas predefinidos, pantalla táctil digital, control preciso de temperatura (80-200°C) y función de deshidratado. Sin aceite hasta 80% menos de grasa.',
    price: 119.00, stock: 14, sku: 'HOG-AIR-004', category_id: 2,
    image_urls: ['https://images.unsplash.com/photo-1623428454614-abaf00244e52?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Lámpara Inteligente LED WiFi',
    description: 'Lámpara de mesa LED inteligente con WiFi integrado, compatible con Alexa y Google Home. Temperatura de color ajustable 2700K-6500K, 16 millones de colores RGB, control por voz y app.',
    price: 39.95, stock: 25, sku: 'HOG-LAM-005', category_id: 2,
    image_urls: ['https://images.unsplash.com/photo-1507473885765-e6ed057ab6fe?w=800&auto=format&fit=crop&q=80']
  },

  # ── Libros (category_id: 3) ──
  {
    name: 'Clean Code: Robert C. Martin',
    description: 'El clásico de Robert C. Martin sobre desarrollo de software limpio. Aprende a escribir código legible, mantenible y modular aplicando principios SOLID con casos prácticos reales.',
    price: 37.95, stock: 50, sku: 'LIB-CC-001', category_id: 3,
    image_urls: ['https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Designing Data-Intensive Applications',
    description: 'La guía definitiva de Martin Kleppmann sobre arquitectura de sistemas de datos. Cubre bases de datos distribuidas, replicación, particionado, consistencia transaccional y procesamiento de streams.',
    price: 45.00, stock: 35, sku: 'LIB-DDIA-002', category_id: 3,
    image_urls: ['https://images.unsplash.com/photo-1532012197267-da84d127e765?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'The Pragmatic Programmer',
    description: 'Edición del 20 aniversario del clásico de Hunt y Thomas. Consejos prácticos sobre artesanía del software, gestión de proyectos, automatización, pruebas y desarrollo ágil para programadores modernos.',
    price: 42.50, stock: 40, sku: 'LIB-PROG-003', category_id: 3,
    image_urls: ['https://images.unsplash.com/photo-1512820790803-83ca734da794?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Cien Años de Soledad',
    description: 'Edición conmemorativa de la obra maestra de Gabriel García Márquez. La historia de la familia Buendía en Macondo, considerada una de las novelas más importantes de la literatura universal.',
    price: 24.95, stock: 60, sku: 'LIB-GGM-004', category_id: 3,
    image_urls: ['https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Introducción a la Inteligencia Artificial',
    description: 'Manual completo de IA moderno: aprendizaje automático, redes neuronales profundas, procesamiento de lenguaje natural, visión por computadora y ética algorítmica. Incluye ejercicios prácticos en Python.',
    price: 49.99, stock: 22, sku: 'LIB-AI-005', category_id: 3,
    image_urls: ['https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=800&auto=format&fit=crop&q=80']
  },

  # ── Deportes (category_id: 4) ──
  {
    name: 'Mochila Técnica Senderismo 45L',
    description: 'Mochila de montaña de 45L en nylon ripstop, funda impermeable integrada, compartimento para hidratación, silbato de emergencia y arnés ergonómico regulable en altura.',
    price: 75.00, stock: 20, sku: 'DEP-MOCH-001', category_id: 4,
    image_urls: ['https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Esterilla Yoga Premium Natural',
    description: 'Esterilla de yoga ecológica de caucho natural con superficie de microfibra. 6 mm de grosor, antideslizante, con línea de alineación grabada y correa de transporte incluida.',
    price: 44.99, stock: 30, sku: 'DEP-YOG-002', category_id: 4,
    image_urls: ['https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'FitBand NebriFit Pro Max',
    description: 'Pulsera de actividad avanzada con GPS integrado, monitor de frecuencia cardíaca, oxímetro SpO2, sensor de temperatura, medición de estrés, 100 modos deportivos y 14 días de batería.',
    price: 149.00, stock: 16, sku: 'DEP-FIT-003', category_id: 4,
    image_urls: ['https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Juego Pesas Rusas Kettlebell 12kg',
    description: 'Kettlebell de hierro fundido con base plana antideslizante, asa ancha ergonómica y recubrimiento de vinilo protector. Ideal para entrenamiento funcional, balanceo y fuerza total.',
    price: 34.95, stock: 25, sku: 'DEP-KET-004', category_id: 4,
    image_urls: ['https://images.unsplash.com/photo-1583454110551-21f2fa2afe61?w=800&auto=format&fit=crop&q=80']
  },
  {
    name: 'Hidratación Deportiva 750ml Acero',
    description: 'Botella térmica de acero inoxidable al vacío de doble pared. Mantiene bebidas frías 24h o calientes 12h. Tapón deportivo de apertura rápida, gancho para mochila y capacidad de 750ml.',
    price: 29.99, stock: 40, sku: 'DEP-BOT-005', category_id: 4,
    image_urls: ['https://images.unsplash.com/photo-1602143407151-7111542de6e8?w=800&auto=format&fit=crop&q=80']
  }
]

products_data.each do |attrs|
  Product.find_or_create_by!(sku: attrs[:sku]) do |p|
    p.name = attrs[:name]
    p.description = attrs[:description]
    p.price = attrs[:price]
    p.stock = attrs[:stock]
    p.category_id = attrs[:category_id]
    p.image_urls = attrs[:image_urls]
  end
end

puts "Creados #{Product.count} productos en #{Category.count} categorías"
