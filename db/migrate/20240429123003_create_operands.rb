class CreateOperands < ActiveRecord::Migration[7.1]
  def change
    create_table :operands do |t|
      t.references :act, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
