import { Controller } from "@hotwired/stimulus"

// Wraps a native <dialog>: open from any button, close on backdrop click.
export default class extends Controller {
  static targets = ["dialog"]

  open() {
    this.dialogTarget.showModal()
    this.dialogTarget.querySelector("[autofocus]")?.focus()
  }

  close() {
    this.dialogTarget.close()
  }

  backdropClick(event) {
    if (event.target === this.dialogTarget) this.close()
  }
}
