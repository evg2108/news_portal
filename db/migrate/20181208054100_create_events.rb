class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.column :title, :string, null: false
      t.column :description, :text, null: false, default: ""
      t.column :begin_time, :datetime, null: false
      t.column :end_time, :datetime, null: false
      t.belongs_to :place, null: false
      t.timestamps
    end

    add_index :events, [:title, :place_id, :begin_time], name: :filter_index1
    add_index :events, [:title, :begin_time], name: :filter_index2
    add_index :events, [:place_id, :begin_time], name: :filter_index3
    add_index :events, :begin_time, name: :filter_index4
    add_index :events, [:place_id, :title, :begin_time, :end_time], name: :uniq_index, unique: true
  end
end
