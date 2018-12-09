class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.column :name, :string, null: false
      t.timestamps
    end

    create_table(:events_tags, id: false) do |t|
      t.references :event
      t.references :tag
    end

    add_index :tags, :name, unique: true
    add_index :events_tags, [:event_id, :tag_id]
  end
end
