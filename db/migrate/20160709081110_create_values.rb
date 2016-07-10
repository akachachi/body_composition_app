class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.integer :user_id
      t.float :weight
      t.float :fat
      t.date :date

      t.timestamps null: false
    end
  end
end
