class CreateCities < ActiveRecord::Migration[5.2]
  def change
    create_table :cities do |t|
      t.column :name, :string, null: false
      t.timestamps
    end

    add_index :cities, :name, unique: true
  end
end
