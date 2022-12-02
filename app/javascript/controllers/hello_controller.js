import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "bookings", "gears", "button", "xbutton"]
  show() {
    this.bookingsTarget.classList.toggle("d-none")
    this.buttonTarget.classList.toggle("active")
  }
  display() {
    this.gearsTarget.classList.toggle("d-none")
    this.xbuttonTarget.classList.toggle("active")
  }

}
