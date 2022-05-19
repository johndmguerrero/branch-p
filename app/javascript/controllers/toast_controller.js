import { Controller } from "@hotwired/stimulus";

export default class extends Controller{
  toastBehavior(){
    var toastElList = [].slice.call(document.querySelectorAll('.toast'))
    var toastList = toastElList.map(function(toastEl) {
      return new bootstrap.Toast(toastEl).show() // No need for options; use the default options
    })
  }

  initialize(){
    this.toastBehavior()
  }
}