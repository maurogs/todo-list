import { Controller } from "@hotwired/stimulus"

// Quick-add form: reveals the extra fields (due date, priority) on demand.
export default class extends Controller {
  static targets = ["details", "title"]

  toggleDetails() {
    this.detailsTarget.classList.toggle("hidden")
  }

  submitOnEnter(event) {
    if (event.key === "Enter" && !event.shiftKey && this.titleTarget.value.trim() === "") {
      event.preventDefault()
    }
  }
}
