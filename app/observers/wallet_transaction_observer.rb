class WalletTransactionObserver < ActiveRecord::Observer

  def after_create(transaction)
    transaction.complete! if transaction.user.owner?
    transaction.complete! if transaction.type.demodulize == "Deposit"
    transaction.complete! if transaction.type.demodulize == "Order"
  end
end