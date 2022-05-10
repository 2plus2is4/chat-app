# frozen_string_literal: true

module Api
  module V1
    class MessagesController < ApplicationController
      include Countable

      before_action :set_chat
      before_action :set_message, only: %i[show update destroy]

      # GET /messages
      def index
        @messages = @chat.messages

        render json: @messages
      end

      # GET /messages/1
      def show
        render json: @message
      end

      # POST /messages
      def create
        @message = @chat.messages.new(
          {
            content: message_params[:content],
            number: increment_count('messages_count', "#{params[:app_id]}_#{params[:chat_id]}")
          }
        )
        if @message.valid?
          CreateRecordJob.perform_later @message.to_json, @message.class.name
          render json: @message, status: :created
        else
          decrement_count('messages_count', "#{params[:app_id]}_#{params[:chat_id]}")
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /messages/1
      def update
        if @message.update(message_params)
          render json: @message
        else
          render json: @message.errors, status: :unprocessable_entity
        end
      end

      # DELETE /messages/1
      def destroy
        @message.destroy
      end

      # GET /messages/search?=word
      def search
        @messages = if params[:query].present?
                      Message.search({ content: params[:query], chat_id: @chat.id })
                    else
                      []
                    end
        render json: @messages.records.present? ? @messages.records : []
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.find_by(
          number: params[:id],
          chat: @chat
        )
      end

      def set_chat
        @app = App.find_by_token(params[:app_id])
        @chat = Chat.find_by(app: @app, number: params[:chat_id])
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:content)
      end
    end
  end
end
