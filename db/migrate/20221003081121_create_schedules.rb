class CreateSchedules < ActiveRecord::Migration[7.0]
  def change
    create_table :schedules do |t|
      t.references :user
      t.date :availability
      t.string :location
      t.string :gender

      t.timestamps
    end
  end
end
