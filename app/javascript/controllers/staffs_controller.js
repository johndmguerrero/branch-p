import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="staffs"
export default class extends Controller {
  static targets = ["tempPassword", "staffForm", "tempPasswordConfirmation"]
  connect() {
    $('#create-user-form').validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element) {
        $(element).valid();  
      },
  
      rules: {
        "staff[email]":{
          required: true,
          email: true
        },
        "staff[first_name]":{
          required: true
        },
        "staff[last_name]":{
          required: true
        },
      },
      errorElement: "span",
      errorPlacement(label, element) {
        label.addClass('invalid-feedback')
        return label.insertAfter($(element).closest('.form-control'))
      },
    });


    $('#reset-password-staff').validate({
      errorClass: 'is-invalid',
      ignore: 'ignore',
  
      onkeyup: function name(element) {
        $(element).valid();  
      },
  
      rules: {
        'security[password]':{
          required: true,
          minlength: 8
        },
  
        'security[password_confirmation]':{
          required: true,
          equalTo: "#security_password"
        }
      },
      errorElement: "span",
      errorPlacement(label, element) {
        label.addClass('invalid-feedback')
        return label.insertAfter($(element).closest('.form-control'))
      },
    })
  }

  initialize(){
  }

  refreshPassword(){
    var new_temp_password = Math.random().toString(32).slice(2, 10)
    this.tempPasswordTarget.value = new_temp_password
    this.tempPasswordConfirmationTarget.value = new_temp_password
  }

  submitUserBtn(e){
    e.preventDefault()

    if($(this.staffFormTarget).valid()){
      $(this.staffFormTarget).trigger('submit')
    }

  }

  submitRessetPassword(e){
    e.preventDefault()
    if( $('#reset-password-staff').valid() ){
      $('#reset-password-staff').trigger('submit')
    }
  }
}
