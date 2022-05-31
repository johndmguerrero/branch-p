class PaymentObserver < ActiveRecord::Observer

  def before_create(payment)
    trans_id = generate_transaction_id(payment)
    payment.transaction_id = trans_id
  end

  private

  def generate_transaction_id(payment)
    transaction_id = loop do
      transaction_id = "#{SecureRandom.hex(3).upcase }-#{SecureRandom.hex(2).upcase}"
      break transaction_id unless payment.class.exists? transaction_id: transaction_id
    end
  end

  def generate_number(order)
    order_number = loop do
      order_number = SecureRandom.hex(3).upcase
      break order_number unless order.class.exists? order_number: order_number
    end

    order_number
  end

end