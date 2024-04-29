class CreateVerbs < ActiveRecord::Migration[7.1]
  def change
    create_table :verbs do |t|
      t.references :team, null: false, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
