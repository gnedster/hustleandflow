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

  # GET /gifts/mobile
  # GET /gifts/mobile.json
  def mobile 
    @gifts = Gift.all

    respond_to do |format|
      format.html # mobile.html.erb
      format.json
    end
  end
end
