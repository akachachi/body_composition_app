class CreateFats < ActiveRecord::Migration
  def change
    create_table :fats do |t|
      t.integer :user_id
      t.float :value
      t.date :date

      t.timestamps null: false
    end
  end
end
