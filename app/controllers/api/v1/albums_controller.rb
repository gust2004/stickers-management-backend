# frozen_string_literal: true

module API
  module V1
    class AlbumsController < ApplicationController
      before_action :load_albums, only: %i[index]
      before_action :load_album, only: %i[show update]

      def index
        render json: @albums, status: :ok
      end

      def show
        render json: @album, status: :ok
      end

      def create
        @album = Album.new(album_params)
        return handle_response(response: @album, status_code: :created) if @album.save

        handle_error_response(response: @album, status_code: :unprocessable_entity)
      end

      def update
        album_updated = @album.update(album_params)
        return handle_response(response: @album, status_code: :ok) if album_updated

        handle_error_response(response: @album, status_code: :unprocessable_entity)
      end

      private

      def load_albums
        @albums = Album.all

        return head :not_found if @albums.empty?
      end

      def load_album
        @album = Album.by_uuid(params[:id])&.first

        return head :not_found if @album.blank?
      end

      def album_params
        params.require(:album).permit(:name, :description, :number_of_stickers)
      end
    end
  end
end
