// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"
import inputmask from "inputmask"
import jquery from "jquery"
import "jquery-validation"

window.$ = jquery
window.jQuery = jquery