# frozen_string_literal: true

module API
  module V1
    class CollectorsController < ApplicationController
      before_action :load_collector, only: %i[show destroy]

      def show
        render json: @collector, status: :ok
      end

      def create
        @collector = Collector.new(collector_params)
        return handle_response(response: @collector, status_code: :created) if @collector.save

        handle_error_response(response: @collector, status_code: :unprocessable_entity)
      end

      def destroy
        return head :no_content if @collector.destroy

        handle_error_response(response: @collector, status_code: :unprocessable_entity)
      end

      private

      def load_collector
        @collector = Collector.by_uuid(params[:id])&.first

        return head :not_found if @collector.blank?
      end

      def collector_params
        params.require(:collector).permit(:name, :email)
      end
    end
  end
end
