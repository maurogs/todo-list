# Demo data. Safe to run repeatedly (`bin/rails db:seed`).
#
# Login: demo@listo.app / password123
#
# In production the demo account is only created when SEED_DEMO_DATA=true,
# so a public deployment doesn't ship a well-known password by accident.
if Rails.env.production? && ENV["SEED_DEMO_DATA"] != "true"
  puts "Skipping demo seeds in production (set SEED_DEMO_DATA=true to load them)."
  return
end

today = Date.current

demo = User.find_or_initialize_by(email_address: "demo@listo.app")
demo.assign_attributes(name: "Demo", password: "password123", password_confirmation: "password123")
demo.save!

# Rebuild the demo user's lists from scratch so the seeds stay deterministic.
demo.lists.destroy_all

data = [
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

data.each_with_index do |attrs, list_index|
  list = demo.lists.create!(attrs.slice(:name, :icon, :color).merge(position: list_index))

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

puts "Seeded #{User.count} user(s), #{List.count} lists and #{Task.count} tasks. Login: demo@listo.app / password123"
