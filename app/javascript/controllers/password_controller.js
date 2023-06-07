import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = [ "password", "toggle" ]
  toggleVisibility(event) {
    this.passwordTargets.forEach((element, index) => {
      if (element.type === "password") {
        element.type = "text";
        this.toggleTargets[index].classList.replace("fa-eye", "fa-eye-slash");
      } else {
        element.type = "password";
        this.toggleTargets[index].classList.replace("fa-eye-slash", "fa-eye");
      }
    })
  }
}
