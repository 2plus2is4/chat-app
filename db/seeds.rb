# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# apps = App.create([{ name: 'app-one' }, { name: 'app-two' }])
# apps.each do |app|
#   chats = Chat.create([{ number: 1, app: app }, { number: 2, app: app }])
#   chats.each do |chat|
#     Message.create([
#                      { number: 1, content: 'hello one', chat: chat },
#                      { number: 2, content: 'hello two', chat: chat },
#                      { number: 3, content: 'hello three', chat: chat },
#                    ])
#   end
# end
Message.__elasticsearch__.create_index!(force: true)
Message.__elasticsearch__.refresh_index!
Message.import
