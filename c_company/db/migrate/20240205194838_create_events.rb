class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :name
      t.datetime :start_time
      t.datetime :end_time
      t.string :location
      t.text :description
      t.integer :activity_id

      t.timestamps
    end
  end
end
