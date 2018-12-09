class CreateFilters < ActiveRecord::Migration[5.2]
  def change
    create_table :filters do |t|
      t.column :name, :string
      t.belongs_to :user, null: false
      t.references :city
      t.column :begin_interval, :datetime
      t.column :end_interval, :datetime
      t.references :tag
      t.timestamps
    end

    add_index :filters, [:user_id, :name]
  end
end
