class AddAncestryToMessages < ActiveRecord::Migration[8.0]
  change_table :messages, bulk: true do |t|
    t.string "ancestry", null: false
    t.index  "ancestry", opclass: :varchar_pattern_ops
  end
end
