class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :user_1
      t.references :user_2
      t.integer :unread_for_user_1
      t.integer :unread_for_user_2

      t.timestamps
    end
  end
end
