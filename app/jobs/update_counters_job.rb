# frozen_string_literal: true

class UpdateCountersJob < ApplicationJob
  def perform
    apps = REDIS_CLIENT.smembers 'chats_count'
    apps.each { |app| App.find_by_token(app).update(chats_count: REDIS_CLIENT.get(app)) }

    app_chats = REDIS_CLIENT.smembers 'messages_count'
    app_chats.each do |app_chat|
      app, chat = app_chat.split '_'
      App.find_by_token(app).chats.find_by_number(chat).update(messages_count: REDIS_CLIENT.get(app_chat))
    end
  end
end
