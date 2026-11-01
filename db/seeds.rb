# Demo data. Safe to run repeatedly (`bin/rails db:seed`).
#
# Logins: demo@listo.app / password123 and tierselfapp@gmail.com / chanteur
#
# In production the demo account is only created when SEED_DEMO_DATA=true,
# so a public deployment doesn't ship a well-known password by accident.
if Rails.env.production? && ENV["SEED_DEMO_DATA"] != "true"
  puts "Skipping demo seeds in production (set SEED_DEMO_DATA=true to load them)."
  return
end

today = Date.current

# Rebuilds a user and their lists from scratch so the seeds stay deterministic.
# `validate: false` only skips the password length rule for the seeded accounts.
def seed_user(email:, name:, password:, lists:)
  user = User.find_or_initialize_by(email_address: email)
  user.assign_attributes(name: name, password: password, password_confirmation: password)
  user.save!(validate: false)

  user.lists.destroy_all

  lists.each_with_index do |attrs, list_index|
    list = user.lists.create!(attrs.slice(:name, :icon, :color).merge(position: list_index))

    attrs[:tasks].each_with_index do |task, task_index|
      list.tasks.create!(
        title: task[:title],
        notes: task[:notes],
        due_on: task[:due_on],
        priority: task[:priority] || :none,
        completed_at: (task[:completed] ? rand(1..5).days.ago : nil),
        position: task_index
      )
    end
  end
end

demo_lists = [
  {
    name: "Casa", icon: "🏠", color: "amber", tasks: [
      { title: "Llamar al fontanero por la fuga del baño", due_on: today - 2, priority: :high },
      { title: "Sacar la basura reciclable", due_on: today, priority: :low },
      { title: "Cambiar las bombillas del salón", notes: "LED cálida, rosca E27. Comprar 4.", due_on: today + 3 },
      { title: "Renovar el seguro del hogar", due_on: today + 10, priority: :medium },
      { title: "Regar las plantas", due_on: today, completed: true },
      { title: "Limpiar el filtro de la campana", completed: true }
    ]
  },
  {
    name: "Trabajo", icon: "💼", color: "indigo", tasks: [
      { title: "Preparar la demo del sprint", notes: "Incluir métricas de rendimiento y los dos bugs críticos resueltos.", due_on: today, priority: :high },
      { title: "Revisar la pull request de autenticación", due_on: today + 1, priority: :medium },
      { title: "Actualizar la documentación de la API", due_on: today + 4, priority: :low },
      { title: "Responder emails pendientes", due_on: today - 1, priority: :medium },
      { title: "Reunión 1:1 con el equipo", due_on: today + 2 },
      { title: "Enviar el informe mensual", completed: true },
      { title: "Planificar el roadmap del trimestre", completed: true }
    ]
  },
  {
    name: "Compras", icon: "🛒", color: "emerald", tasks: [
      { title: "Leche de avena" },
      { title: "Café en grano", notes: "El de tueste medio de siempre." },
      { title: "Pan de masa madre", due_on: today },
      { title: "Fruta de temporada" },
      { title: "Detergente" },
      { title: "Huevos camperos", completed: true }
    ]
  },
  {
    name: "Viaje a Lisboa", icon: "✈️", color: "sky", tasks: [
      { title: "Reservar el hotel en Alfama", due_on: today + 5, priority: :high },
      { title: "Comprar los billetes de tren", due_on: today + 6, priority: :medium },
      { title: "Hacer una lista de restaurantes", notes: "Pastéis de Belém, Time Out Market y una tasca local." },
      { title: "Revisar el pasaporte" },
      { title: "Cambiar algo de dinero", completed: true }
    ]
  },
  {
    name: "Aprender", icon: "📚", color: "violet", tasks: [
      { title: "Terminar el capítulo de Hotwire", priority: :medium, due_on: today + 7 },
      { title: "Practicar 20 minutos de guitarra", due_on: today },
      { title: "Ver la charla de Rails World", priority: :low },
      { title: "Leer 30 páginas del libro", completed: true }
    ]
  },
  {
    name: "Bienestar", icon: "💪", color: "rose", tasks: [
      { title: "Salir a correr 5 km", due_on: today + 1, priority: :medium },
      { title: "Reservar cita con el dentista", due_on: today - 3, priority: :high },
      { title: "Meditar 10 minutos", due_on: today },
      { title: "Beber 2 litros de agua", completed: true }
    ]
  }
]
seed_user(email: "demo@listo.app", name: "Demo", password: "password123", lists: demo_lists)

tierself_lists = [
  {
    name: "Limpiar la casa", icon: "🏠", color: "amber", tasks: [
      { title: "Aspirar y fregar todo el suelo", due_on: today + 1, priority: :medium },
      { title: "Limpiar el baño a fondo", due_on: today + 2, priority: :medium },
      { title: "Limpiar la cocina y la nevera", due_on: today + 3 },
      { title: "Cambiar las sábanas y poner la lavadora", due_on: today },
      { title: "Limpiar las ventanas" },
      { title: "Sacar la basura y el reciclaje", completed: true }
    ]
  },
  {
    name: "Cuarto del fondo", icon: "📦", color: "orange", tasks: [
      { title: "Vaciar las cajas y decidir qué se queda", priority: :high, due_on: today + 4 },
      { title: "Separar lo que se tira, se dona y se vende", notes: "Tres montones: tirar, donar y vender." },
      { title: "Tirar los trastos que sobran" },
      { title: "Montar las estanterías nuevas", notes: "Cuando lleguen del Ikea." },
      { title: "Etiquetar las cajas y colocarlas", priority: :low },
      { title: "Medir el cuarto para las estanterías", completed: true }
    ]
  },
  {
    name: "Comprar en el Ikea", icon: "🛒", color: "sky", tasks: [
      { title: "Comprar estanterías para el cuarto del fondo", notes: "Anotar antes las medidas del cuarto.", priority: :high, due_on: today + 5 },
      { title: "Cajas de almacenaje con tapa" },
      { title: "Tornillos y tacos para fijar las estanterías a la pared" },
      { title: "Ver si caben en el coche o pedir el envío", priority: :medium },
      { title: "Hacer la lista con las referencias del catálogo", completed: true }
    ]
  },
  {
    name: "Trabajo", icon: "💼", color: "indigo", tasks: [
      { title: "Seguir con la app de automatismos para después de morir", notes: "Mensajes programados, gestión de cuentas y avisos a familiares.", priority: :high, due_on: today + 2 },
      { title: "Seguir con el Wallapop de ordenadores", notes: "Anuncios, filtros por especificaciones y chat entre compradores.", priority: :medium, due_on: today + 3 },
      { title: "Seguir con la app de ligar para infieles", priority: :medium },
      { title: "Desplegar las apps en Coolify", priority: :low },
      { title: "Comprar los dominios", completed: true }
    ]
  },
  {
    name: "Aprender", icon: "💡", color: "violet", tasks: [
      { title: "Probar agentes y automatizaciones con Claude Code" },
      { title: "Montar un servidor casero con Proxmox", priority: :medium },
      { title: "Aprender a hacer Tailwind y Hotwire como un pro" },
      { title: "Ver cómo funciona un LLM por dentro (embeddings y RAG)", priority: :low },
      { title: "Hacer un proyecto con Arduino o Raspberry Pi" },
      { title: "Aprender filipino (tagalo) básico para la familia", priority: :medium }
    ]
  },
  {
    name: "Viaje: Filipinas, Vietnam y Japón", icon: "✈️", color: "emerald", tasks: [
      { title: "1. Volar a Manila", notes: "Reservar el vuelo y revisar pasaporte y visados.", priority: :high },
      { title: "2. Dos días en Manila con la familia", notes: "2 días." },
      { title: "3. Vietnam", notes: "4 días." },
      { title: "4. Japón", notes: "8 días." },
      { title: "5. Volver a Manila", notes: "Vuelo de vuelta desde Japón." },
      { title: "6. Viajar a Victoria (Mindoro) con la familia", notes: "9 días.", priority: :medium }
    ]
  }
]

seed_user(email: "tierselfapp@gmail.com", name: "Tierself", password: "chanteur", lists: tierself_lists)

puts "Seeded #{User.count} user(s), #{List.count} lists and #{Task.count} tasks."
puts "Logins: demo@listo.app / password123 and tierselfapp@gmail.com / chanteur"
