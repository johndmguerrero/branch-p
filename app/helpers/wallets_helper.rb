module WalletsHelper

  def wallet_index_view
    if @wallet_transactions.present?
      render partial: 'wallets/partials/table'
    else
      render partial: 'wallets/placeholders/table'
    end
  end

  def wallet_transaction_index_status(status)
    helper = {
      complete: 'success',
      pending: 'warning',
      decline: 'danger',
    }
    color = helper[status.to_sym]
    "<span class='badge text-uppercase bg-soft-#{color} text-#{color}'>#{status}</span>".html_safe
  end

  def wallet_transaction_index_type(type)
    helper = {
      order: 'success',
      withdraw: 'warning',
      deposit: 'success',
      expense: 'dark'
    }
    return color = helper[type.downcase.to_sym]
  end
end
