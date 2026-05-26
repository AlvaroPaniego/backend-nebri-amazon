# 📦 NebriAmazon - Backend API

API REST de comercio electrónico para **NebriAmazon**, proyecto académico de la **Universidad Nebrija**. Construida con Ruby on Rails 7 (API-only), PostgreSQL y JWT.

---

## 🛠️ Tecnologías

| Tecnología | Versión | Propósito |
|------------|---------|-----------|
| **Ruby** | >= 3.2 | Lenguaje de programación |
| **Rails** | 7.1 (API-only) | Framework web |
| **PostgreSQL** | >= 14 | Base de datos relacional |
| **Puma** | ~6.0 | Servidor web |
| **JWT** | — | Autenticación sin estado |
| **Bcrypt** | — | Hash de contraseñas |
| **Rack-CORS** | — | Control de acceso cross-origin |
| **RSpec** | — | Testing |

---

## ✨ Características

- **Autenticación JWT** — Registro, login y perfil con roles (admin / customer).
- **Catálogo** — CRUD de productos con filtros por categoría y búsqueda textual.
- **Categorías** — Listado de categorías para filtrar productos.
- **Carrito persistente** — Carrito en base de datos sincronizado por usuario.
- **Pedidos** — Creación de pedidos con bloqueo pesimista (`SELECT FOR UPDATE`) para prevenir venta excesiva.
- **Chatbot** — Endpoint de asistencia virtual pasiva.
- **CORS** — Configurado para desarrollo con Vite (puerto 5173).

---

## 📂 Estructura

```text
backend-nebri-amazon/
├── app/
│   ├── controllers/api/   # Controladores REST (auth, products, cart, orders, chatbot, categories)
│   ├── models/            # Modelos ActiveRecord (User, Product, Cart, Order, Category...)
│   └── services/          # Service Objects (lógica de negocio desacoplada)
├── config/
│   ├── routes.rb          # Definición de rutas
│   └── initializers/      # Configuración (CORS, JWT...)
├── db/
│   ├── migrate/           # Migraciones PostgreSQL
│   └── seeds.rb           # Datos de prueba (4 categorías, 20 productos)
└── spec/                  # Tests RSpec
```

---

## 🚀 Requisitos e Instalación

### 1. Requisitos previos

- **Ruby 3.2+** — Instalar con [rbenv](https://github.com/rbenv/rbenv) o [rvm](https://rvm.io/):
  ```bash
  rbenv install 3.2.2
  rbenv global 3.2.2
  ```
- **PostgreSQL 14+** — Instalar con el gestor de paquetes del sistema:
  ```bash
  # Ubuntu/Debian
  sudo apt install postgresql postgresql-contrib libpq-dev
  # macOS
  brew install postgresql@16
  ```
- **Bundler** — Gestor de dependencias Ruby:
  ```bash
  gem install bundler
  ```

### 2. Clonar e instalar dependencias

```bash
cd backend-nebri-amazon
bundle install
```

### 3. Configurar base de datos

Edita `config/database.yml` si es necesario (usuario, contraseña, host). Por defecto usa `dummy_app_development` con el usuario del sistema.

Crear la base de datos y ejecutar migraciones:

```bash
bin/rails db:create
bin/rails db:migrate
```

### 4. Poblar con datos de prueba

```bash
bin/rails db:seed
```

Esto crea 4 categorías y 20 productos (5 por categoría).

### 5. Iniciar el servidor

```bash
bin/rails server
```

El servidor arranca en `http://localhost:3000`.

---

## 🔗 Endpoints de la API

| Método | Endpoint | Descripción | Auth |
| :--- | :--- | :--- | :---: |
| **POST** | `/api/auth/register` | Registrar nuevo usuario | ❌ |
| **POST** | `/api/auth/login` | Iniciar sesión (devuelve JWT) | ❌ |
| **GET** | `/api/auth/me` | Perfil del usuario autenticado | 🔑 |
| **GET** | `/api/categories` | Listar todas las categorías | ❌ |
| **GET** | `/api/categories/:id` | Detalle de una categoría | ❌ |
| **GET** | `/api/products` | Listar productos (`?category_id=X&search=Y`) | ❌ |
| **GET** | `/api/products/:id` | Detalle de un producto | ❌ |
| **POST** | `/api/products` | Crear producto (admin) | 🔑 |
| **PUT** | `/api/products/:id` | Actualizar producto (admin) | 🔑 |
| **DELETE** | `/api/products/:id` | Eliminar producto lógico (admin) | 🔑 |
| **GET** | `/api/cart` | Ver carrito del usuario | 🔑 |
| **POST** | `/api/cart/items` | Añadir ítem al carrito | 🔑 |
| **PUT** | `/api/cart/items/:id` | Actualizar cantidad de ítem | 🔑 |
| **DELETE** | `/api/cart/items/:id` | Eliminar ítem del carrito | 🔑 |
| **POST** | `/api/orders` | Crear pedido (checkout) | 🔑 |
| **GET** | `/api/orders` | Listar pedidos del usuario | 🔑 |
| **GET** | `/api/orders/:id` | Detalle de un pedido | 🔑 |
| **POST** | `/api/chatbot` | Enviar mensaje al chatbot | ❌ |

> 🔑 = Requiere header `Authorization: Bearer <token>`

---

## 🧪 Tests

```bash
bin/rails spec
```

---

## 📜 Licencia

MIT
