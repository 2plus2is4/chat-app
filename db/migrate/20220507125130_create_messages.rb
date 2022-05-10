class CreateMessages < ActiveRecord::Migration[5.2]
  def up
    create_table :messages, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.bigint :number, null: false
      t.string :content
      t.references :chat, type: :string

      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
