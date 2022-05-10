# frozen_string_literal: true

class CreateApps < ActiveRecord::Migration[5.2]
  def up
    create_table :apps, id: false do |t|
      t.string :id, limit: 36, primary_key: true
      t.string :name, null: false
      t.string :token, index: { unique: true }, null: false
      t.integer :chats_count, null: false, default: 0

      t.timestamps
    end
  end

  def down
    drop_table :apps
  end
end
