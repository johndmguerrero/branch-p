import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["itemCard", "itemFileInput", "itemEditForm"]

  connect(){

    $.validator.addMethod("valueNotEquals", function(value, element, arg){
      return arg !== value;
     }, "Please select Category");

    $('#item-form').validate({
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
    var item_form = $('#item-form')
    if(item_form.valid()){
      item_form.trigger('submit')
    }
  }

  previewImage(){
    const [file] = this.itemFileInputTarget.files
    if (file) {
      var card = this.itemCardTarget
      card.style.background = `linear-gradient(rgba(255,255,255,.5), rgba(255,255,255,.5)), url(${URL.createObjectURL(file)})`
      card.style.backgroundSize = 'cover';
      card.style.height = '250px';
    }
  }

}