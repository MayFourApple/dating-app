class AddLocationAndGenderToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :location
      t.string :gender
    end
  end
end
