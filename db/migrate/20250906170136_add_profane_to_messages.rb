class AddProfaneToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :profane, :boolean, default: false
  end
end
