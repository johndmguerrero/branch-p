module StaffsHelper

  def staff_index_table
    if @staffs.present?
      render partial: 'staffs/partials/table'
    else
      render partial: 'staffs/placeholders/table'
    end
  end

  def staff_set_status_btn
    if @staff.active?
      button_to archive_staff_path(@staff.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-square'></i>
        </span>
        <span>Set Archive</span>".html_safe
      end
    else
      button_to active_staff_path(@staff.id), method: :post, class: 'btn shadow d-inline-flex btn-sm btn-neutral border-base mx-1', form_class: 'd-inline-flex' do
        "<span class=' pe-2'>
          <i class='bi bi-check-square'></i>
        </span>
        <span>Set Active</span>".html_safe
      end
    end
  end
end
