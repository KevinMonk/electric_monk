class CreateActs < ActiveRecord::Migration[7.1]
  def change
    create_table :acts do |t|
      t.references :defining_verb, null: false, foreign_key: {to_table: "verbs"}
      t.references :calling_verb, null: false, foreign_key: {to_table: "verbs"}

      t.timestamps
    end
  end
end
