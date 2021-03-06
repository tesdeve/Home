class CreateInvites < ActiveRecord::Migration[6.0]
  def change
    create_table :invites do |t|
      t.string :email
      t.string :token
      t.integer :sender_id
      t.integer :recipient_id
      t.integer :building_id
      t.boolean :accepted

      t.timestamps
    end
  end
end
