class AddConfirmationSentToPayment < ActiveRecord::Migration[6.0]
  def change
    add_column :payments, :confirmation_sent, :integer, default: 0
  end
end
