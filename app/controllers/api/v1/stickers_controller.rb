# frozen_string_literal: true

module API
  module V1
    class StickersController < ApplicationController
      before_action :load_collection, :load_stickers, only: %i[index]
      before_action :load_sticker, only: %i[update]

      def index
        render json: @stickers, status: :ok
      end

      def update
        sticker_updated = @sticker.update(sticker_params)
        return handle_response(response: @sticker, status_code: :ok) if sticker_updated

        handle_error_response(response: @sticker, status_code: :unprocessable_entity)
      end

      private

      def load_collection
        @collection = Collection.by_uuid(params[:collection_id])&.first

        return head :not_found if @collection.blank?
      end

      def load_stickers
        @stickers = Sticker.by_collection(@collection)

        return head :not_found if @stickers.empty?
      end

      def load_sticker
        @sticker = Sticker.by_uuid(params[:id])&.first

        return head :not_found if @sticker.blank?
      end

      def sticker_params
        params.require(:sticker).permit(:quantity)
      end
    end
  end
end
