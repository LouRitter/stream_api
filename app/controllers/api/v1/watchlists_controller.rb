module Api
    module V1
      class WatchlistsController < ApplicationController
        before_action :authenticate_user!
  
        # GET /watchlists
        def index
          watchlist = current_user.watchlists.includes(:video)
          render json: watchlist.as_json(include: :video), status: :ok
        end
  
        # POST /watchlists
        def create
          watchlist = current_user.watchlists.build(video_id: params[:video_id])
          if watchlist.save
            render json: watchlist, status: :created
          else
            render json: watchlist.errors, status: :unprocessable_entity
          end
        end
  
        # DELETE /watchlists/:id
        def destroy
          watchlist = current_user.watchlists.find(params[:id])
          watchlist.destroy
          head :no_content
        end
      end
    end
  end