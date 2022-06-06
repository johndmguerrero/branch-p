class WalletTransactionObserver < ActiveRecord::Observer

  def after_create(transaction)
    transaction.complete! if transaction.user.owner?
    transaction.complete! if transaction.type.demodulize == "Deposit"
  end
end