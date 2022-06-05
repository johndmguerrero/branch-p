class WalletService
  attr_accessor :params, :user, :valid, :wallet

  def initialize(options = {})
    self.params   = options[:params]
    self.user     = options[:user]
    self.valid    = false
    self.wallet   = options[:wallet]
  end

  def transact!
    type = build_transaction(params[:type])
    if type.present?
      transaction = type.constantize.new(amount: params[:amount_cents], remarks: params[:remarks], wallet: wallet, user: user)
      transaction.save
    end
  end

  def build_transaction(build_type)
    transaction = WalletTransaction.transactions_types.to_h { |type| [type.demodulize.downcase, type]}
    transaction[build_type]
  end
end