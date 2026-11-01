# Listo

Una app sencilla y bonita para organizar tus tareas en listas. Construida con Rails 8.1, Hotwire (Turbo + Stimulus), Tailwind CSS 4 y SQLite.

## Funcionalidades

- Cuentas de usuario (registro, login y logout) con las listas de cada persona totalmente aisladas.
- Listas con icono y color propios; se reordenan arrastrando en la barra lateral.
- Tareas con notas, fecha límite y prioridad; se completan, editan en línea, eliminan y reordenan arrastrando.
- Pantalla de inicio con tareas vencidas, de hoy y de los próximos 7 días, y estadísticas.
- Experiencia tipo single page app: Turbo Drive con *page refresh morphing*, Turbo Frames para la edición en línea y Stimulus para las interacciones. Sin build de JavaScript (importmap).
- Modo claro y oscuro, y diseño responsive.

## Requisitos

- Ruby 4.0.9 (ver `.tool-versions` / `.ruby-version`)
- SQLite 3

## Desarrollo

```sh
bin/setup          # instala dependencias, prepara la base de datos y arranca el servidor
bin/dev            # servidor + watcher de Tailwind
bin/rails db:seed  # datos de demostración
```

Con los seeds se crea el usuario de demostración **demo@listo.app** / **password123**, con 6 listas y unas 30 tareas.

> Si tu shell exporta `DATABASE_URL` (por ejemplo, para otro proyecto con Postgres), Rails la usará en lugar de `config/database.yml`. Desactívala para este proyecto: `unset DATABASE_URL`.

## Tests y calidad

```sh
bin/rails test        # tests de modelos y flujos
bin/ci                # todo lo que ejecuta la integración continua
```

GitHub Actions (`.github/workflows/ci.yml`) ejecuta Brakeman, bundler-audit, importmap audit, RuboCop y los tests en cada push a `main` y en cada pull request.

## Despliegue (Coolify)

La app se despliega con el `Dockerfile` incluido. Variables de entorno necesarias:

| Variable | Descripción |
| --- | --- |
| `RAILS_MASTER_KEY` | Contenido de `config/master.key` (no se versiona). |
| `SEED_DEMO_DATA` | Opcional. Con `true` se carga el usuario/listas de demostración en la primera creación de la base de datos. |
| `FORCE_SSL` | Por defecto `true` (Coolify termina TLS). Usa `false` solo para probar por http. |

- El contenedor escucha en el puerto **80** y expone el healthcheck en `/up`.
- La base de datos SQLite vive en `/rails/storage`: **monta ahí un volumen persistente** o se perderán los datos en cada despliegue.
