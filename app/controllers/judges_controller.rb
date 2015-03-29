class JudgesController < ApplicationController
  #TODO: Fix this autocomplete to be able to search for the full name
  autocomplete :judge, :first_name, :full => true, :extra_data => [:last_name], :display_value => :full_name

  # GET /judges
  # GET /judges.json
  def index
    @judges = Judge.all.sort_by { |j| j.total_value}.reverse

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @judges }
    end
  end

  # GET /judges/1
  # GET /judges/1.json
  def show
    @judge = Judge.find(params[:id])
    #TODO: find donors with their respective gifts to their judge

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @judge }
    end
  end
end
