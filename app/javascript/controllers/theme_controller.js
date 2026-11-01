import { Controller } from "@hotwired/stimulus"

// Toggles the `dark` class on <html> and remembers the choice. The initial
// state is applied by an inline script in the layout to avoid a flash.
export default class extends Controller {
  toggle() {
    const dark = document.documentElement.classList.toggle("dark")
    localStorage.setItem("theme", dark ? "dark" : "light")
  }
}
