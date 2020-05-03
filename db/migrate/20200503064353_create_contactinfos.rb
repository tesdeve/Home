class CreateContactinfos < ActiveRecord::Migration[6.0]
  def change
    create_table :contactinfos do |t|
      t.references :contactable, polymorphic: true, null: false
      t.string :telephone
      t.string :email
      t.string :mobile

      t.timestamps
    end
  end
end


