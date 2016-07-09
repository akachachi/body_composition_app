class AddRegsiterFromUsers < ActiveRecord::Migration
  def change
    add_column :users, :register_date, :date
  end
end
