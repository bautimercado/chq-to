# Trabajo Integrado - TTPS Ruby 2023

## Alumno:

- Bautista Mercado
- 18477/0
- mercadob267@gmail.com

## Dependencias:

- Ruby 2.7.8
- Rails 7.1.2
- devise
- validates_timeliness
- tailwindcss-rails
- kaminari

# Instalación

1. Clonar repositorio

```bash
git clone git@github.com:bautimercado/chq-to.git
```

2. Instalar dependencias

```bash
bundle install
```

3. Crear base de datos

```bash
rails db:migrate
```

4. Llenar base de datos con datos iniciales

```bash
rails db:seeds
```

5. Tailwindcss build

```bash
rails assets:precompile
rails tailwindcss:build
```

6. Ejecutar aplicación

```bash
rails s
```

7. En el navegador de preferencia, ir a `localhost:3000` o `127.0.0.1:3000`

# Decisiones de diseño.

## Gestión de usuarios

- Para el manejo de usuario se utilizó la gema `devise` y se le agregó el campo _username_, el cuál es único y puede ser editado.
- La contraseña debe tener 3 digítos como mínimo.
- La autenticación se realiza con correo electrónico y contraseña.
- Para editar la información del usuario, es necesario escribir su contraseña.

## Gestión de links

- El slug (cadena de caracteres) es único por cada link. Consta de una cadena de 7 caracteres alfanuméricos.
- 4 tipos de links: Regular, Temporal, Efímero y Privado.
- Para los links privados, la contraseña se hashea con `BCrypt`.
- Cuando se intenta acceder a los links privados, se renderiza una vista para ingresar la contraseña.
- El efímero tiene un único acceso.
- Todos los páginados son de 5 elementos por página.
- Con cada acceso exitoso, se registra el acceso (a qué link, dirección IP y timestamp)

## Reportes sobre links

- Cantidad de accesos por día: Utilizando un `group` y `count` por _created_at_
- Reporte de accesos: Se muestra la IP del cliente, junto con la fecha y hora de acceso. Se puede filtrar por rango de fechas y/o dirección IP.

