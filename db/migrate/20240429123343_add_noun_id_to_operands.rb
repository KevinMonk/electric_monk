class AddNounIdToOperands < ActiveRecord::Migration[7.1]
  def change
    add_reference :operands, :noun, null: true, foreign_key: true
  end
end
