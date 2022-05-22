import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";

// Connects to data-controller="point-of-sales"
export default class extends Controller {
  connect() {

  }

  addCart({params: { id, orderId}}) {
    const payload = {
      id: id,
      order_id: orderId
    }

    fetch(`point_of_sales/${id}/add_to_cart.turbo_stream`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payload)
    }).then( response => response.text())
      .then((response) => {
      Turbo.renderStreamMessage(response)
    }).catch(e => console.log(e))
  }

  removeItem({params: { itemId, orderId }}){
    const payload = {
      id: itemId,
      order_id: orderId
    }
    // /point_of_sales/:id/remove_item
    fetch(`point_of_sales/${itemId}/remove_item.turbo_stream`,{
      method: 'POST',
      headers: {
        "X-CSRF-Token": this.getMetaValue("csrf-token"),
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(payload)
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
