class HomeController < ApplicationController
  def visualization
    gon.judges = Judge.all()
  end


end
