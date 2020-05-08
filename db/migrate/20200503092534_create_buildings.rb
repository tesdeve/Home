class CreateBuildings < ActiveRecord::Migration[6.0]
  def change
    create_table :buildings do |t|
      t.string :name      
      t.boolean :status
      t.integer :buildingtype

      t.timestamps
    end
  end
end
