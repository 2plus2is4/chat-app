class Chat < ApplicationRecord
  belongs_to :app
  has_many :messages, dependent: :destroy

  # def as_json(options = {})
  #   puts 'AYOOOOOOOOOOOO'
  #   if options[:except].present?
  #     options[:except].push(:app_id)
  #   else
  #     options[:except] = [:app_id]
  #   end
  #   super
  # end
end
