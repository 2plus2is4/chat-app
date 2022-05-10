class ChatSerializer < ActiveModel::Serializer
  attributes :number, :app_token, :messages_count

  def app_token
    object.app.token
  end
end
