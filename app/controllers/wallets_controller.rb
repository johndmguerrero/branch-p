class WalletsController < ApplicationController
  before_action :authenticate_user!
  before_action :wallet_transaction_params, only: [:create_transaction]
  before_action :set_wallet, only: [:create_transaction]
  before_action :set_transaction, only: [:complete_transaction]

  def index
    @wallet = current_wallet
    @wallet_transactions = @wallet.wallet_transactions.includes(:user).paginate(page: params[:page])
    @sum_today_order = WalletTransaction.today_total_order.map(&:amount)
    @sum_today_expense = WalletTransaction.today_total_expense.map(&:amount)
    @sum_today_withdraw = WalletTransaction.today_total_withdraw.map(&:amount)
  end

  def create_transaction
    @wallet = WalletService.new(params: wallet_transaction_params, user: current_user, wallet: @wallet)
    @wallet.transact!

    redirect_to wallets_path, flash: { notice: "Transaction Created" }
  end

  def complete_transaction
    @wallet_transaction&.complete!

    redirect_to wallets_path, flash: { notice: "Transaction Completed" }
  end

  private
    
  def wallet_transaction_params
    params.require(:wallet_transactions).permit(
      :wallet_transaction,
      :type,
      :amount_cents,
      :remarks
    )
  end

  def set_wallet
    @wallet = Wallet.find_by id: params[:id]
  end

  def set_transaction
    @wallet_transaction = WalletTransaction.find_by id: params[:id]
  end
end
