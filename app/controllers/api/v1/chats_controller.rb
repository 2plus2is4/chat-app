# frozen_string_literal: true

module Api
  module V1
    class ChatsController < ApplicationController
      include Countable

      before_action :set_app
      before_action :set_chat, only: %i[show update destroy]

      # GET /chats
      def index
        @chats = @app.chats

        render json: @chats
      end

      # GET /chats/1
      def show
        render json: @chat
      end

      # POST /chats
      def create
        @chat = @app.chats.new(
          {
            number: increment_count('chats_count', params[:app_id])
          }
        )
        if @chat.valid?
          CreateRecordJob.perform_later @chat.to_json, @chat.class.name
          render json: @chat, status: :created
        else
          decrement_count('chats_count', params[:app_id])
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /chats/1
      def update
        if @chat.update(chat_params)
          render json: @chat
        else
          render json: @chat.errors, status: :unprocessable_entity
        end
      end

      # DELETE /chats/1
      def destroy
        decrement_count('chats_count', params[:app_id]) if @chat.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_chat
        @chat = Chat.find_by(number: params[:id], app: @app)
      end

      def set_app
        @app = App.find_by_token(params[:app_id])
      end

      # Only allow a trusted parameter "white list" through.
      def chat_params
        params.require(:chat).permit(:app)
      end
    end
  end
end
