class ChangeIsGuestFromUser < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :is_Guest
    add_column :users, :is_guest, :boolean

  end
end
