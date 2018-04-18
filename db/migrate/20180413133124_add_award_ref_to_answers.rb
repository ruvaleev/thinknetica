class AddAwardRefToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :award, :integer
  end
end