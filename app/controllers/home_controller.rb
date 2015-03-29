class HomeController < ApplicationController
  def index
    @judges_count = Judge.all.count
    @donors_count = Donor.all.count

    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
