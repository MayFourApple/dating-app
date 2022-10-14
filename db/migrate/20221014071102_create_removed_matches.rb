class CreateRemovedMatches < ActiveRecord::Migration[7.0]
  def change
    create_table :removed_matches do |t|
      t.references :schedule_1
      t.references :schedule_2
      t.timestamps
    end
  end
end
