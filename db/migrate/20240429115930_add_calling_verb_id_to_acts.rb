class AddCallingVerbIdToActs < ActiveRecord::Migration[7.1]
  def change
    add_reference :acts, :calling_verb, null: true, foreign_key: {to_table: "verbs"}
  end
end
