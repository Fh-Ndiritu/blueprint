class CreateMessages < ActiveRecord::Migration[8.0]
  def change
    create_table :messages do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :content
      t.belongs_to :group, null: false, foreign_key: true

      t.timestamps
    end
  end
end
