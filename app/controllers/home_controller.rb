class HomeController < ApplicationController
  caches_page :index, :gzip => :best_speed
  def index
    @judges_count = Judge.all.count
    @donors_count = Donor.all.count

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
