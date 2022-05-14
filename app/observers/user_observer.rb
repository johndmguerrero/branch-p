class UserObserver < ActiveRecord::Observer

  def before_create(user)
    account_number = generate_number(user)
    user.account_number = account_number
  end
  
  private

  def generate_number(user)
    account_number = loop do
      account_number = SecureRandom.hex(4).upcase
      break account_number unless user.class.exists? account_number: account_number
    end
    
    account_number
  end
end