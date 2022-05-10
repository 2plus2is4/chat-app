class MessageSerializer < ActiveModel::Serializer
  attributes :number, :chat_number, :content

  def chat_number
    object.chat.number
  end
end
