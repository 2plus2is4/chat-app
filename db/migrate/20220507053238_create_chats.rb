class CreateChats < ActiveRecord::Migration[5.2]
  def up
    create_table :chats, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.bigint :number, null: false
      t.integer :messages_count, null: false, default: 0
      t.references :app, type: :string

      t.timestamps
    end
  end

  def down
    drop_table :chats
  end
end
