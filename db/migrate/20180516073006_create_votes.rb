class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :answers, :users, table_name: :votes do |t|
      t.index :answer_id
      t.index :user_id
      t.boolean :positive

      t.timestamps
    end
  end
end
