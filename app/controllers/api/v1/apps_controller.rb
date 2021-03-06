# frozen_string_literal: true
module Api
  module V1
    class AppsController < ApplicationController
      before_action :set_app, only: %i[show update destroy]

      # GET /apps
      def index
        @apps = App.all

        render json: @apps
      end

      # GET /apps/1
      def show
        render json: @app
      end

      # POST /apps
      def create
        @app = App.new(app_params)

        if @app.save
          render json: @app, status: :created
        else
          render json: @app.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /apps/1
      def update
        if @app.update(app_params)
          render json: @app
        else
          render json: @app.errors, status: :unprocessable_entity
        end
      end

      # DELETE /apps/1
      def destroy
        @app.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_app
        @app = App.find_by_token(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def app_params
        params.require(:app).permit(:name)
      end
    end
  end
end
