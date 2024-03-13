import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="counter-buttons"
export default class extends Controller {
  static targets = ["counter", "input"]

  connect() {
    this.inputTarget.value = this.counterTarget.innerText
  }
  plus(event) {
    this.counterTarget.innerText = parseInt(this.counterTarget.innerText) + 1
    this.inputTarget.value = this.counterTarget.innerText
  }
  minus(event) {
    this.counterTarget.innerText = parseInt(this.counterTarget.innerText) - 1
    this.inputTarget.value = this.counterTarget.innerText
  }
}
