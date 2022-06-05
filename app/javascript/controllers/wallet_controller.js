import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="wallet"
export default class extends Controller {
  static targets = ['walletBalance', 'amountField', 'walletTransactionForm']

  connect() {
    this.maskInput(this.walletBalanceTarget)
    this.maskInput(this.amountFieldTarget)
    this.bindWalletValidation(this.walletTransactionFormTarget)
  }

  initialize(){

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

  bindWalletValidation(form){
    $.validator.addMethod("valueNotEquals", function(value, element, arg){
      return arg !== value;
     }, "Please select Type Transaction");
  
    $(form).validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element) {
        $(element).valid();  
      },
  
      rules: {
        "wallet_transactions[amount_cents]":{
          required: true,
        },
        "wallet_transactions[type]":{
          required: true,
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

  submitWalletTransaction(){
    var wallet_form = $(this.walletTransactionFormTarget)
    
    if(!wallet_form.valid()){
      return false
    }
  }

}
