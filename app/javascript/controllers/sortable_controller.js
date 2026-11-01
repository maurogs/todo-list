import { Controller } from "@hotwired/stimulus"

// Dependency-free drag & drop reordering using the native HTML5 API.
// Children matching `[data-sortable-id]` are draggable; the new order is
// PATCHed as `ids[]` to the url value.
export default class extends Controller {
  static values = { url: String }

  connect() {
    this.dragging = null
    this.element.querySelectorAll("[data-sortable-id]").forEach((item) => (item.draggable = true))
  }

  start(event) {
    const item = event.target.closest("[data-sortable-id]")
    if (!item) return
    this.dragging = item
    event.dataTransfer.effectAllowed = "move"
    event.dataTransfer.setData("text/plain", item.dataset.sortableId)
    requestAnimationFrame(() => item.classList.add("sortable-ghost"))
  }

  over(event) {
    if (!this.dragging) return
    event.preventDefault()
    const after = this.itemAfter(event.clientY)
    if (after == null) this.element.appendChild(this.dragging)
    else if (after !== this.dragging) this.element.insertBefore(this.dragging, after)
  }

  end() {
    if (!this.dragging) return
    this.dragging.classList.remove("sortable-ghost")
    this.dragging = null
    this.save()
  }

  itemAfter(y) {
    const items = [...this.element.querySelectorAll("[data-sortable-id]:not(.sortable-ghost)")]
    return items.find((item) => {
      const box = item.getBoundingClientRect()
      return y < box.top + box.height / 2
    })
  }

  save() {
    const body = new FormData()
    this.element.querySelectorAll("[data-sortable-id]").forEach((item) => body.append("ids[]", item.dataset.sortableId))

    fetch(this.urlValue, {
      method: "PATCH",
      headers: { "X-CSRF-Token": document.querySelector("meta[name=csrf-token]").content, Accept: "text/vnd.turbo-stream.html" },
      body
    })
  }
}
