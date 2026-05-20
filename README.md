# 📦 NebriAmazon - Backend API 🚀

[![Node.js Version](https://img.shields.io/badge/node-%3E%3D%2018.0.0-blue.svg?style=flat-square)](https://nodejs.org/)
[![API Status](https://img.shields.io/badge/api-active-emerald.svg?style=flat-square)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

Este repositorio contiene la **API REST** y la lógica del servidor para **NebriAmazon**, una plataforma de comercio electrónico inspirada en Amazon, desarrollada como proyecto académico para la **Universidad Nebrija**.

El backend se encarga de gestionar la persistencia de datos, la lógica de negocio, la autenticación de usuarios y la pasarela de pedidos/carrito de compra.

---

## 🛠️ Tecnologías y Herramientas

El backend está diseñado utilizando un stack robusto y moderno:

*   **Entorno de Ejecución:** [Node.js](https://nodejs.org/) (o similar)
*   **Framework:** [Express.js](https://expressjs.com/) / Fastify (API REST estructurada)
*   **Base de Datos:** MongoDB / PostgreSQL (Mongoose / Sequelize / Prisma ORM)
*   **Autenticación:** JWT (JSON Web Tokens) & Bcrypt para encriptación de contraseñas
*   **Herramientas de Test:** Jest / Supertest

---

## ✨ Características Principales

*   🔒 **Autenticación Segura:** Registro de usuarios, inicio de sesión y gestión de sesiones mediante JSON Web Tokens (JWT).
*   🛍️ **Catálogo de Productos:** Operaciones CRUD (Crear, Leer, Actualizar, Borrar) para productos, categorías y filtrado avanzado.
*   🛒 **Carrito y Pedidos:** Gestión de carritos de compra persistentes y simulación del proceso de checkout y pago.
*   👤 **Perfiles de Usuario:** Gestión de datos de usuario, direcciones de envío e historial de pedidos.
*   🛡️ **Seguridad:** Middlewares para el manejo de errores, prevención de CORS, inyección SQL/NoSQL y límites de peticiones (rate limiting).

---

## 📂 Estructura del Proyecto

Una arquitectura modular y limpia para facilitar la escalabilidad:

```text
backend-nebri-amazon/
├── config/             # Configuración de base de datos y variables globales
├── controllers/        # Controladores de la lógica de negocio para cada ruta
├── middlewares/        # Middlewares de seguridad, validación y autenticación
├── models/             # Modelos y esquemas de la Base de Datos
├── routes/             # Definición de endpoints de la API (index, auth, products...)
├── utils/              # Funciones auxiliares y utilidades comunes
├── .env.template       # Plantilla para variables de entorno
├── app.js              # Inicialización de la aplicación Express
└── server.js           # Punto de entrada del servidor
```

---

## 🚀 Cómo Empezar (Desarrollo)

### 1. Requisitos Previos

Asegúrate de tener instalado:
*   [Node.js](https://nodejs.org/) (versión 18 o superior)
*   [npm](https://www.npmjs.com/) (generalmente viene con Node) o [yarn](https://yarnpkg.com/)
*   Una base de datos activa (local o en la nube como MongoDB Atlas / Supabase)

### 2. Instalación de Dependencias

Clona e instala los paquetes necesarios dentro del directorio del backend:

```bash
cd backend-nebri-amazon
npm install
```

### 3. Configuración de Variables de Entorno

Crea un archivo `.env` en la raíz de esta carpeta basándote en `.env.template`:

```bash
PORT=5000
MONGODB_URI=mongodb://localhost:27017/nebriamazon
JWT_SECRET=tu_clave_secreta_super_segura
NODE_ENV=development
```

### 4. Ejecución del Servidor

Para iniciar el servidor en modo desarrollo con recarga automática:

```bash
npm run dev
```

El servidor estará escuchando en `http://localhost:5000` (o el puerto configurado).

---

## 🔗 Endpoints Principales (Resumen)

| Método | Endpoint | Descripción | Requiere Auth |
| :--- | :--- | :--- | :---: |
| **POST** | `/api/auth/register` | Registro de nuevo usuario | ❌ |
| **POST** | `/api/auth/login` | Login y obtención del token | ❌ |
| **GET** | `/api/products` | Obtener lista de productos con filtros | ❌ |
| **GET** | `/api/products/:id` | Detalle de un producto específico | ❌ |
| **POST** | `/api/cart` | Añadir producto al carrito | 🔑 |
| **GET** | `/api/cart` | Obtener el carrito del usuario | 🔑 |
| **POST** | `/api/orders` | Procesar compra (Checkout) | 🔑 |

---

## 📜 Licencia

Este proyecto está bajo la Licencia MIT. Consulta el archivo `LICENSE` para más detalles (si aplica).
