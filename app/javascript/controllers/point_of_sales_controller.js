import { Controller } from "@hotwired/stimulus"
import { Turbo } from "@hotwired/turbo-rails";
import inputmask from "inputmask";

// Connects to data-controller="point-of-sales"
export default class extends Controller {
  static targets = ["confirmFormTag", 
                    "amountToPay", 
                    "received", 
                    "packageOrderDetailModal", 
                    "orderDetailPackageModalTitle",
                    "PackageProductId",
                    'orderItemDiscount',
                    "discountItemForm"
                  ]

  initialize(){
    this.maskInput(this.amountToPayTarget)
    this.maskInput(this.receivedTarget)
  }

  connect() {
    var offcanvasElementList = [].slice.call(document.querySelectorAll('.offcanvas'))
    var offcanvasList = offcanvasElementList.map(function (offcanvasEl) {
      return new bootstrap.Offcanvas(offcanvasEl)
    })

    
    window.PackageOrderDetail = new bootstrap.Modal(this.packageOrderDetailModalTarget, {keyboard: false})
    window.DiscountItemModal = new bootstrap.Modal(this.discountItemFormTarget, {keyboard: false})

    document.addEventListener("turbo:submit-end", function(e){
      // if (e.detail.formSubmission.)
      window.formsubmitted = e.detail.formSubmission
      if(e.detail.formSubmission.formElement.id == 'apply-item-order-form'){
        window.DiscountItemModal.hide();
      }
    })
    
    this.bindConfirmFromValidation(this.confirmFormTagTarget)

    $.validator.addMethod("EmptyNumber", function(value, element, arg){
      var total = document.getElementById('amount-to-pay').value
      var recv = document.getElementById('received').value
      var unmaskedValue = parseFloat(recv.replace(/\,/g,''), 10)
      var total_value = parseFloat(total.replace(/\,/g,''), 10)
      var result = false
      if(unmaskedValue >= total_value){
        result = true
      }
      return result != false
    }, "Please input Greater Amount");
  }

  addCart({params: { id, orderId, productType, name}}) {
    const payload = {
      id: id,
      order_id: orderId,
    }

    if(productType == 'package'){
      window.PackageOrderDetail.show()
      this.orderDetailPackageModalTitleTarget.innerHTML = name
      this.PackageProductIdTarget.value = id
    }else{
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

  formValidate(event){
    var checkout_form = $(this.confirmFormTagTarget)
    
    if(!checkout_form.valid()){
      return false
    }
  }

  getMetaValue(name) {
    const element = document.head.querySelector(`meta[name="${name}"]`)
    return element.getAttribute("content")
  }

  // functions

  maskInput(field){
    var im = new Inputmask({
          prefix: "",
          groupSeparator: ".",
          alias: "numeric",
          placeholder: "0",
          autoGroup: true,
          digits: 2,
          digitsOptional: false,
          clearMaskOnLostFocus: false,
          allowMinus: false,
          min: 0,
          removeMaskOnSubmit: true,
          onBeforeMask: function (value, opts) {
            return value;
          },
      });
    im.mask(field);
  }

  unmaskedValue(field){
    
  }

  bindConfirmFromValidation(form){
    $(form).validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element) {
        $(element).valid();
      },
  
      rules: {
        "received":{
          required: true,
          EmptyNumber: true
        },
      },
      errorElement: "span",
      errorPlacement(label, element) {
        label.addClass('invalid-feedback')
        return label.insertAfter($(element).closest('.form-control'))
      },
    });
  }

  addItemDiscount({params: { itemId }}){
    window.DiscountItemModal.show()
    this.orderItemDiscountTarget.value = itemId
  }

  removeItemDiscount({params: { itemId, orderId }}){
    const payload = {
      id: itemId,
      order_id: orderId
    }

    fetch(`point_of_sales/${itemId}/remove_discount_item.turbo_stream`,{
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


  amountToPayTargetConnected(){
    this.maskInput(this.amountToPayTarget)
  }
  receivedTargetConnected(){
    this.maskInput(this.receivedTarget)
  }
  confirmFormTagTargetConnected(){
    this.bindConfirmFromValidation(this.confirmFormTagTarget)
  }
}
