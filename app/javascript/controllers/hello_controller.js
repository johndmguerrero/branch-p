import { Controller } from "@hotwired/stimulus"

export default class extends Controller {


  maskInput(field){
    var number_field = document.getElementById(field)
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
    im.mask(number_field);
  }

  connect() {
    this.maskInput('product_price')
    this.maskInput('product_cost')

    $.validator.addMethod("valueNotEquals", function(value, element, arg){
      return arg !== value;
     }, "Please select Category");
  
    $('#product-form').validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element) {
        $(element).valid();  
      },
  
      rules: {
        "product[name]":{
          required: true
        },
        "product[category_id]":{
          valueNotEquals: ""
        },
      },
      errorElement: "span",
      errorPlacement(label, element) {
        label.addClass('invalid-feedback')
        return label.insertAfter($(element).closest('.form-control'))
      },
    });
  }

  submitForm(){
    var product_form = $('#product-form')
    if(product_form.valid()){
      product_form.trigger('submit')
    }
  }

  initialize(){
    // this.toastBehavior()
  }

}
