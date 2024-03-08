import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="counter-buttons"
export default class extends Controller {
  connect() {
    console.log("hi")
  }
  plus(event) {
    console.log(event)
  }
  minus(event) {
    console.log(event)
  }
}
