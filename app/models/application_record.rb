class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  before_validation :set_uuid, on: :create
  validates :id, presence: true

  # def as_json(options = {})
  #   if options[:except].present?
  #     options[:except].push(:id)
  #   else
  #     options[:except] = [:id]
  #   end
  #   super
  # end

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
