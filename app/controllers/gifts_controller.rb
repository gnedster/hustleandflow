class GiftsController < ApplicationController
  # GET /gifts
  # GET /gifts.json
  def index
    @gifts = Gift.all

    respond_to do |format|
      format.html # index.html.erb
      format.json
    end
  end
end
