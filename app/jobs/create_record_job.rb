# frozen_string_literal: true

class CreateRecordJob < ApplicationJob
  include Countable
  queue_as :default

  def perform(record, klass)
    resource = klass.constantize
    object = JSON.parse(record)
    resource.new(object).save!
  end
end
