module ApplicationHelper
  # Full class names (no interpolation) so Tailwind can detect them.
  COLOR_STYLES = {
    "indigo" => {
      dot: "bg-indigo-500",
      bar: "bg-indigo-500",
      soft: "bg-indigo-50 text-indigo-700 dark:bg-indigo-500/15 dark:text-indigo-300",
      text: "text-indigo-600 dark:text-indigo-400",
      active: "bg-indigo-50 text-indigo-900 dark:bg-indigo-500/15 dark:text-indigo-100",
      check: "border-indigo-500 bg-indigo-500",
      hover: "hover:border-indigo-500"
    },
    "violet" => {
      dot: "bg-violet-500",
      bar: "bg-violet-500",
      soft: "bg-violet-50 text-violet-700 dark:bg-violet-500/15 dark:text-violet-300",
      text: "text-violet-600 dark:text-violet-400",
      active: "bg-violet-50 text-violet-900 dark:bg-violet-500/15 dark:text-violet-100",
      check: "border-violet-500 bg-violet-500",
      hover: "hover:border-violet-500"
    },
    "pink" => {
      dot: "bg-pink-500",
      bar: "bg-pink-500",
      soft: "bg-pink-50 text-pink-700 dark:bg-pink-500/15 dark:text-pink-300",
      text: "text-pink-600 dark:text-pink-400",
      active: "bg-pink-50 text-pink-900 dark:bg-pink-500/15 dark:text-pink-100",
      check: "border-pink-500 bg-pink-500",
      hover: "hover:border-pink-500"
    },
    "rose" => {
      dot: "bg-rose-500",
      bar: "bg-rose-500",
      soft: "bg-rose-50 text-rose-700 dark:bg-rose-500/15 dark:text-rose-300",
      text: "text-rose-600 dark:text-rose-400",
      active: "bg-rose-50 text-rose-900 dark:bg-rose-500/15 dark:text-rose-100",
      check: "border-rose-500 bg-rose-500",
      hover: "hover:border-rose-500"
    },
    "orange" => {
      dot: "bg-orange-500",
      bar: "bg-orange-500",
      soft: "bg-orange-50 text-orange-700 dark:bg-orange-500/15 dark:text-orange-300",
      text: "text-orange-600 dark:text-orange-400",
      active: "bg-orange-50 text-orange-900 dark:bg-orange-500/15 dark:text-orange-100",
      check: "border-orange-500 bg-orange-500",
      hover: "hover:border-orange-500"
    },
    "amber" => {
      dot: "bg-amber-500",
      bar: "bg-amber-500",
      soft: "bg-amber-50 text-amber-700 dark:bg-amber-500/15 dark:text-amber-300",
      text: "text-amber-600 dark:text-amber-400",
      active: "bg-amber-50 text-amber-900 dark:bg-amber-500/15 dark:text-amber-100",
      check: "border-amber-500 bg-amber-500",
      hover: "hover:border-amber-500"
    },
    "emerald" => {
      dot: "bg-emerald-500",
      bar: "bg-emerald-500",
      soft: "bg-emerald-50 text-emerald-700 dark:bg-emerald-500/15 dark:text-emerald-300",
      text: "text-emerald-600 dark:text-emerald-400",
      active: "bg-emerald-50 text-emerald-900 dark:bg-emerald-500/15 dark:text-emerald-100",
      check: "border-emerald-500 bg-emerald-500",
      hover: "hover:border-emerald-500"
    },
    "sky" => {
      dot: "bg-sky-500",
      bar: "bg-sky-500",
      soft: "bg-sky-50 text-sky-700 dark:bg-sky-500/15 dark:text-sky-300",
      text: "text-sky-600 dark:text-sky-400",
      active: "bg-sky-50 text-sky-900 dark:bg-sky-500/15 dark:text-sky-100",
      check: "border-sky-500 bg-sky-500",
      hover: "hover:border-sky-500"
    }

  }.freeze

  PRIORITY_STYLES = {
    "high" => "bg-rose-50 text-rose-700 dark:bg-rose-500/15 dark:text-rose-300",
    "medium" => "bg-amber-50 text-amber-700 dark:bg-amber-500/15 dark:text-amber-300",
    "low" => "bg-sky-50 text-sky-700 dark:bg-sky-500/15 dark:text-sky-300"
  }.freeze

  PRIORITY_LABELS = { "none" => "Sin prioridad", "low" => "Baja", "medium" => "Media", "high" => "Alta" }.freeze

  MONTHS = %w[ene feb mar abr may jun jul ago sep oct nov dic].freeze
  WEEKDAYS = %w[domingo lunes martes miércoles jueves viernes sábado].freeze
  FULL_MONTHS = %w[enero febrero marzo abril mayo junio julio agosto septiembre octubre noviembre diciembre].freeze

  ICON_PATHS = {
    eye: "M2.036 12.322a1.012 1.012 0 0 1 0-.639C3.423 7.51 7.36 4.5 12 4.5c4.638 0 8.573 3.007 9.963 7.178.07.207.07.431 0 .639C20.577 16.49 16.64 19.5 12 19.5c-4.638 0-8.573-3.007-9.963-7.178ZM15 12a3 3 0 1 1-6 0 3 3 0 0 1 6 0Z",
    eye_slash: "M3.98 8.223A10.477 10.477 0 0 0 1.934 12C3.226 16.338 7.244 19.5 12 19.5c.993 0 1.953-.138 2.863-.395M6.228 6.228A10.451 10.451 0 0 1 12 4.5c4.756 0 8.773 3.162 10.065 7.498a10.522 10.522 0 0 1-4.293 5.774M6.228 6.228 3 3m3.228 3.228 3.65 3.65m7.894 7.894L21 21m-3.228-3.228-3.65-3.65m0 0a3 3 0 1 0-4.243-4.243m4.242 4.242L9.88 9.88",
    plus: "M12 4.5v15m7.5-7.5h-15",
    check: "m4.5 12.75 6 6 9-13.5",
    pencil: "m16.862 4.487 1.687-1.688a1.875 1.875 0 1 1 2.652 2.652L10.582 16.07a4.5 4.5 0 0 1-1.897 1.13L6 18l.8-2.685a4.5 4.5 0 0 1 1.13-1.897l8.932-8.931Zm0 0L19.5 7.125M18 14v4.75A2.25 2.25 0 0 1 15.75 21H5.25A2.25 2.25 0 0 1 3 18.75V8.25A2.25 2.25 0 0 1 5.25 6H10",
    trash: "m14.74 9-.346 9m-4.788 0L9.26 9m9.968-3.21c.342.052.682.107 1.022.166m-1.022-.165L18.16 19.673a2.25 2.25 0 0 1-2.244 2.077H8.084a2.25 2.25 0 0 1-2.244-2.077L4.772 5.79m14.456 0a48.108 48.108 0 0 0-3.478-.397m-12 .562c.34-.059.68-.114 1.022-.165m0 0a48.11 48.11 0 0 1 3.478-.397m7.5 0v-.916c0-1.18-.91-2.164-2.09-2.201a51.964 51.964 0 0 0-3.32 0c-1.18.037-2.09 1.022-2.09 2.201v.916m7.5 0a48.667 48.667 0 0 0-7.5 0",
    menu: "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5",
    x: "M6 18 18 6M6 6l12 12",
    sun: "M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12 18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z",
    moon: "M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 12.75 21a9.753 9.753 0 0 0 9.002-5.998Z",
    calendar: "M6.75 3v2.25M17.25 3v2.25M3 18.75V7.5a2.25 2.25 0 0 1 2.25-2.25h13.5A2.25 2.25 0 0 1 21 7.5v11.25m-18 0A2.25 2.25 0 0 0 5.25 21h13.5A2.25 2.25 0 0 0 21 18.75m-18 0v-7.5A2.25 2.25 0 0 1 5.25 9h13.5A2.25 2.25 0 0 1 21 11.25v7.5",
    logout: "M15.75 9V5.25A2.25 2.25 0 0 0 13.5 3h-6a2.25 2.25 0 0 0-2.25 2.25v13.5A2.25 2.25 0 0 0 7.5 21h6a2.25 2.25 0 0 0 2.25-2.25V15m3 0 3-3m0 0-3-3m3 3H9",
    home: "m2.25 12 8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25",
    note: "M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m0 12.75h7.5m-7.5 3H12M10.5 2.25H5.625c-.621 0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z",
    flag: "M3 3v1.5M3 21v-6m0 0 2.77-.693a9 9 0 0 1 6.208.682l.108.054a9 9 0 0 0 6.086.71l3.114-.732a48.524 48.524 0 0 1-.005-10.499l-3.11.732a9 9 0 0 1-6.085-.711l-.108-.054a9 9 0 0 0-6.208-.682L3 4.5M3 15V4.5",
    chevron: "m19.5 8.25-7.5 7.5-7.5-7.5",
    grip: "M8.25 6.75h.008v.008H8.25V6.75Zm0 5.25h.008v.008H8.25V12Zm0 5.25h.008v.008H8.25v-.008Zm7.5-10.5h.008v.008h-.008V6.75Zm0 5.25h.008v.008h-.008V12Zm0 5.25h.008v.008h-.008v-.008Z"
  }.freeze

  def icon(name, classes: "size-5", stroke: 1.75)
    tag.svg(class: classes, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 24 24",
            stroke_width: stroke, stroke: "currentColor", aria: { hidden: true }) do
      tag.path(d: ICON_PATHS.fetch(name), stroke_linecap: "round", stroke_linejoin: "round")
    end
  end

  def color_styles(color)
    COLOR_STYLES.fetch(color) { COLOR_STYLES["indigo"] }
  end

  def pluralize_tasks(count)
    count == 1 ? "1 tarea" : "#{count} tareas"
  end

  def short_date(date)
    "#{date.day} #{MONTHS[date.month - 1]}#{" #{date.year}" if date.year != Date.current.year}"
  end

  def long_today
    today = Date.current
    "#{WEEKDAYS[today.wday].capitalize}, #{today.day} de #{FULL_MONTHS[today.month - 1]}"
  end

  def greeting
    case Time.current.hour
    when 5..11 then "Buenos días"
    when 12..19 then "Buenas tardes"
    else "Buenas noches"
    end
  end

  def due_label(date)
    case (date - Date.current).to_i
    when 0 then "Hoy"
    when 1 then "Mañana"
    when -1 then "Ayer"
    when 2..6 then WEEKDAYS[date.wday].capitalize
    else short_date(date)
    end
  end
end
