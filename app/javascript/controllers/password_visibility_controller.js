import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "showIcon", "hideIcon", "toggleButton"]

  toggle() {
    const isHidden = this.inputTarget.type === "password"

    this.inputTarget.type = isHidden ? "text" : "password"
    this.showIconTarget.classList.toggle("d-none", isHidden)
    this.hideIconTarget.classList.toggle("d-none", !isHidden)

    this.toggleButtonTarget.setAttribute("aria-pressed", isHidden)
    this.toggleButtonTarget.setAttribute("aria-label", isHidden ? "Hide password" : "Show password")
  }
}
