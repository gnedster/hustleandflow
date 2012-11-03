class HomeController < ApplicationController
  def index
    @top_judges = Judge.all().sort_by { |j| j.total_value}.reverse![0..4]

  end
end
