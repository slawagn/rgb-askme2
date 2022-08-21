import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ 'picker' ]
  
  set(event) {
    const color  = event.params.color
    const picker = this.pickerTarget;

    picker.value = color;
  }
}

