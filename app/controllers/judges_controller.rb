class JudgesController < ApplicationController
  autocomplete :judge, :full_name

  # GET /judges
  # GET /judges.json
  def index
    @judges = Judge.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @judges }
    end
  end

  # GET /judges/1
  # GET /judges/1.json
  def show
    @judge = Judge.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @judge }
  end

    #def create_graph
    #  neo = Neography::Rest.new
    #  graph_exists = neo.get_node_properties(1)
    #  return if graph_exists && graph_exists['name']
    #
    #  node_judge = neo.create_node("name" => "#{@judge.first_name} #{@judge.last_name}")
    #
    #  @judge.gifts.each do |x|
    #    node_gift = neo.create_node("name" => x.description, "value" => x.value)
    #    neo.set_node_properties(node_gift, {"weight" => x.value})
    #    neo.create_relationship("donated_gifts", node_judge, node_gift)
    #    node_donor = neo.create_node("name" => x.donor.name)
    #    neo.create_relationship("donor", node_gift, node_donor)
    #  end
    #
    #end
  end

end
