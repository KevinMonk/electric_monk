class AddSubjectIdToVerbs < ActiveRecord::Migration[7.1]
  def change
    add_reference :verbs, :subject, null: true, foreign_key: {to_table: "nouns"}
  end
end
