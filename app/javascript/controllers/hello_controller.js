import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "bookings", "gears"]
  show() {
    this.bookingsTarget.classList.toggle("d-none")
  }
  display() {
    this.gearsTarget.classList.toggle("d-none")
  }

}
