import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="product"
export default class extends Controller {
  static targets = ["productCard", "productFileInput", "productCostInput", "productPriceInput", "productEditForm"]

  connect() {
    this.maskInput(this.productCostInputTarget)
    this.maskInput(this.productPriceInputTarget)
  }

  initialize(){
    $.validator.addMethod("valueNotEquals", function(value, element, arg){
      return arg !== value;
     }, "Please select Category");
  
    $('#product-edit-form').validate({
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

  previewImage(){
    const [file] = this.productFileInputTarget.files
    if (file) {
      var card = this.productCardTarget
      card.style.background = `linear-gradient(rgba(255,255,255,.5), rgba(255,255,255,.5)), url(${URL.createObjectURL(file)})`
      card.style.backgroundSize = 'cover';
      card.style.height = '250px';
    }
  }

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

  submitProductBtn(e){
    e.preventDefault()

    if($(this.productEditFormTarget).valid()){
      $(this.productEditFormTarget).trigger('submit')
    }

  }
}
