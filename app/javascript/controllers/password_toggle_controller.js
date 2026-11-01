import { Controller } from "@hotwired/stimulus"

// Shows or hides a password field.
export default class extends Controller {
  static targets = ["input", "show", "hide"]

  toggle() {
    const reveal = this.inputTarget.type === "password"
    this.inputTarget.type = reveal ? "text" : "password"
    this.showTarget.classList.toggle("hidden", reveal)
    this.hideTarget.classList.toggle("hidden", !reveal)
  }
}
