import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="counter-buttons"
export default class extends Controller {
  static targets = ["counter", "input"]

  connect() {
    console.log(parseInt(this.counterTarget.innerText) + 1)
  }
  plus(event) {
    this.counterTarget.innerText = parseInt(this.counterTarget.innerText) + 1
    this.inputTarget.value = this.counterTarget.innerText
  }
  minus(event) {
    this.counterTarget.innerText = parseInt(this.counterTarget.innerText) - 1
  }
}
