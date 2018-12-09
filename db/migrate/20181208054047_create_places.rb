class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.column :title, :string, null: false
      t.column :description, :text, null: false, default: ""
      t.belongs_to :city
      t.timestamps
    end

    add_index :places, [:city_id, :title], unique: true
  end
end
