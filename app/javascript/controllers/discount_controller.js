import { Controller } from "@hotwired/stimulus";

export default class extends Controller {

  connect(){
    $.validator.addMethod('CondDiscount', function(value, element,arg){
      let discount_select = $('.radio-select-discount-input:checked')
      var dup = false
  
      if (discount_select.val() == 'percent' ){
        if( value <= 100 && value > 0){
          dup = true
        }else{
          $(element).data('error-message', 'Value should not be greater than 100 when discount is selected')
        }
      }else if(discount_select.val() == 'amount'){
        if( value >= 0){
          dup = true
        }else{
          $(element).data('error-message', 'Value should not be below 0 when amount is selected')
        }
      }
      return dup
    }, function(param, element){
      return $(element).data('error-message')
    });

    $('#apply-item-order-form').validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element){
        $(element).valid();
      },
  
      rules: {
        'discount[input]':{
          required: true,
          CondDiscount: true
        }
      },
  
      errorElement: "span",
      errorPlacement(label, element) {
        label.addClass('invalid-feedback')
        return label.insertAfter($(element).closest('.form-control'))
      },
    });
  }

  validateChange(e){
    if($('#discount_input').val() == 0 || $('#discount_input').val() == ''){
      return false
    }else{
      $('#apply-item-order-form').valid();
    }
  }

}