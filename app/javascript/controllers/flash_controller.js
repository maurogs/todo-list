import { Controller } from "@hotwired/stimulus"

// Toast that dismisses itself after a few seconds.
export default class extends Controller {
  static values = { delay: { type: Number, default: 4000 } }

  connect() {
    this.timeout = setTimeout(() => this.dismiss(), this.delayValue)
  }

  disconnect() {
    clearTimeout(this.timeout)
  }

  dismiss() {
    this.element.classList.add("opacity-0", "translate-y-2")
    setTimeout(() => this.element.remove(), 200)
  }
}
