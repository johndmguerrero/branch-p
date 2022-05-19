module ApplicationHelper


  def toastr_flash
    flash.map do |type, message|
      next unless message # why do all that processing just to skip it at the end?
      type = 'bg-success' if type == 'notice'
      type = 'bg-danger' if type == 'alert'
      text = "<div class='toast align-items-center text-white "+ type +" border-0 position-fixed m-3 bottom-0 start-0' role='alert' aria-live='assertive' aria-atomic='true'><div class='d-flex'><div class='toast-body'>#{message}</div><button type='button' class='btn-close btn-close-white me-2 m-auto' data-bs-dismiss='toast' aria-label='Close'></button></div></div>"
    end.reject(&:blank?).join.html_safe
  end

  def active_page(link_path)
    current_page?(link_path, check_parameters: true) ? 'active' : ''
  end

end
