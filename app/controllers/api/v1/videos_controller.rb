module Api
    module V1
      class VideosController < ApplicationController
        before_action :set_video, only: [:show, :update, :destroy]
  
        # GET /videos
        def index
            videos = Video.all
            videos = videos.where("title ILIKE ?", "%#{params[:search]}%") if params[:search]
            videos = videos.where(genre: params[:genre]) if params[:genre]
            render json: videos, status: :ok
        end
  
        # GET /videos/:id
        def show
            @video = Video.find(params[:id])
            authorize @video
            render json: @video
        end

        # POST /videos
        def create
          video = Video.new(video_params)
          if video.save
            render json: video, status: :created
          else
            render json: video.errors, status: :unprocessable_entity
          end
        end
  
        # PUT /videos/:id
        def update
          if @video.update(video_params)
            render json: @video, status: :ok
          else
            render json: @video.errors, status: :unprocessable_entity
          end
        end
  
        # DELETE /videos/:id
        def destroy
          @video.destroy
          head :no_content
        end
  
        private
  
        def set_video
          @video = Video.find(params[:id])
        end
  
        def video_params
          params.require(:video).permit(:title, :description, :duration, :genre, :release_date, :rating, files: [])
        end
      end
    end
  end
  