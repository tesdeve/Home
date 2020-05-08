class CreateEngagements < ActiveRecord::Migration[6.0]
  def change
    create_table :engagements do |t|
      t.references :building, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.date :started_at
      t.date :ended_at
      t.integer :role

      t.timestamps
    end
  end
end
