class App < ApplicationRecord
  has_secure_token :token
  has_many :chats, dependent: :destroy

end
