class AddGuestTokenToUser < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :guest_token, :string
    add_column :users, :is_Guest, :boolean
  end
end
