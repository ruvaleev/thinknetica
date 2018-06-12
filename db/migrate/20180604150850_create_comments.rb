class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.integer :user_id
      t.index :commentable_id
      t.index :user_id
      t.text :body

      t.timestamps
    end
  end
end
