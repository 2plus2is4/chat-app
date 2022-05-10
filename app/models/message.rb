# frozen_string_literal: true

require 'elasticsearch/model'

class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat

  # index_name Rails.application.class.parent_name.underscore
  # index_name [Rails.application.class.parent_name.underscore, name.downcase].join('_')
  # document_type name.downcase

  settings index: { number_of_shards: 1 } do
    mapping dynamic: true do
      indexes :content, analyzer: 'standard'
      indexes :chat_id, analyzer: 'keyword'
    end
  end

  # def as_indexed_json(_options = nil)
  #   as_json(only: [:content])
  # end

  def self.search(query)
    # __elasticsearch__.search query[:content]
    __elasticsearch__.search(
      {
        "query": {
          "bool": {
            "must": {
              "multi_match": {
                "query": ".*#{query[:content]}.*",
                "fields": [
                  'content'
                ]
              }
            },
            "filter": {
              "term": {
                "chat_id": query[:chat_id]
              }
            }
          }
        }
      }
    )
  end
end
