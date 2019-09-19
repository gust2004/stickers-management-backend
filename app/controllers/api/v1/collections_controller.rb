# frozen_string_literal: true

module API
  module V1
    class CollectionsController < ApplicationController
      before_action :load_collector, only: %i[index show create destroy]
      before_action :load_album, only: %i[create]
      before_action :load_collections, only: %i[index]
      before_action :load_collection, only: %i[show destroy]

      def index
        render json: @collections, status: :ok
      end

      def show
        render json: @collection, status: :ok
      end

      def create
        @collection = Collection.new(build_collection_params)
        if @collection.save
          create_stickers
          handle_response(response: @collection, status_code: :created)
        else
          handle_error_response(response: @collection, status_code: :unprocessable_entity)
        end
      end

      def destroy
        return head :no_content if @collection.destroy

        handle_error_response(response: @collection, status_code: :unprocessable_entity)
      end

      private

      def create_stickers
        @collection.album.number_of_stickers.times { |number| create_sticker(number + 1) }
      end

      def create_sticker(number)
        Sticker.create(collection: @collection, number: number)
      end

      def load_collector
        @collector = Collector.by_uuid(params[:collector_id])&.first

        return head :not_found if @collector.blank?
      end

      def load_album
        @album = Album.by_uuid(params[:album_id])&.first

        return head :not_found if @album.blank?
      end

      def load_collections
        @collections = Collection.by_collector(@collector)

        return head :not_found if @collections.empty?
      end

      def load_collection
        @collection = Collection.by_uuid(params[:id])&.first

        return head :not_found if @collection.blank?
      end

      def build_collection_params
        { collector: @collector, album: @album }
      end

      def collection_params
        params.require(:collection).permit(:album_id, :collector_id)
      end
    end
  end
end
