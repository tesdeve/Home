class CreateEngagements < ActiveRecord::Migration[6.0]
  def change
    create_table :engagements do |t|
      t.references :building, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :started_at
      t.boolean :end
      t.datetime :ended_at
      t.integer :role
      t.integer :creator

      t.timestamps
    end
  end
end
