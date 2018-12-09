class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false
      t.belongs_to :topic, null: false
      t.column :message, :string, null: false
      t.timestamps
    end
  end
end
