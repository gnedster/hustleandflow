require 'rest_client'

BASE_URL = 'http://ballotpedia.org/'
API_BASE_URL = BASE_URL + 'wiki/api.php'

class JudgesController < ApplicationController
  #TODO: Fix this autocomplete to be able to search for the full name
  autocomplete :judge, :first_name, :full => true, :extra_data => [:last_name], :display_value => :full_name
  caches_page :index, :gzip => :best_speed
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
    @judge = Judge.includes(gifts: [:donor]).find(params[:id])

    begin
      res = Hash.from_xml(RestClient.get API_BASE_URL, {:accept => :xml,
                                            :params => {
                                            :format => :xml,
                                            :action => :query,
                                            :titles => @judge.full_name,
                                            :prop => 'info'
        }
      })

      @ballotpediaLink = BASE_URL + res['api']['query']['pages']['page']['title'].gsub!(' ', '_')
    rescue
      logger.warn 'Searching Ballotpedia failed.'
    ensure
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @judge }
      end
    end
  end
end
