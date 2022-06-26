import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect(){
  }

  editCategory(event){
    event.preventDefault();

    fetch(`categories/${event.params.id}/edit.turbo_stream`,{
      method: 'GET'
    }).then( response => response.text())
      .then((response) => {
      Turbo.renderStreamMessage(response)
    }).catch(e => console.log(e))
  }

  removeCategory(event){
    event.preventDefault();

    // /point_of_sales/:id/remove_item
    fetch(`/categories/${event.params.id}/remove_category.turbo_stream`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        'Content-Type': 'application/json',
      },
      // body: JSON.stringify(payload)
    }).then( response => response.text())
      .then((response) => {
      Turbo.renderStreamMessage(response)
    }).catch(e => console.log(e))
  }


  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }
}