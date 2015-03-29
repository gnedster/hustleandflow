class DonorsController < ApplicationController
  caches_page :index, :gzip => :best_speed
  # GET /donors
  # GET /donors.json
  def index
    @donors = Donor.all.sort_by { |j| j.total_value}.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @donors }
    end
  end

  # GET /donors/1
  # GET /donors/1.json
  def show
    @donor = Donor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @donor }
    end
  end
end
