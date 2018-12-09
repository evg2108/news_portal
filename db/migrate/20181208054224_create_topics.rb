class CreateTopics < ActiveRecord::Migration[5.2]
  def change
    create_table :topics do |t|
      t.column :title, :string, null: false
      t.column :description, :text, null: false, default: ""
      t.belongs_to :event, null: false
      t.timestamps
    end

    add_index :topics, [:event_id, :title], unique: true
  end
end
