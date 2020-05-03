class AddExtraFieldsToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string  
    add_column :users, :lastname, :string  
    add_column :users, :username, :string  
    add_column :users, :telephone, :string  
    add_column :users, :terms, :boolean, default: false
    add_column :users, :role, :integer
  end
end



