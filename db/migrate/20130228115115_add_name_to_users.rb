class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :admin, :bool
    add_column :users, :slug, :string
    add_column :users, :public, :bool
  end
end
