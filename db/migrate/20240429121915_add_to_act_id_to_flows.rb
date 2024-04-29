class AddToActIdToFlows < ActiveRecord::Migration[7.1]
  def change
    add_reference :flows, :to_act, null: true, foreign_key: {to_table: "acts"}
  end
end
