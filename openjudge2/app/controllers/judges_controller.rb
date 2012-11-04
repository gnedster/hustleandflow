require 'neography'

class JudgesController < ApplicationController
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

  # GET /judges/new
  # GET /judges/new.json
  def new
    @judge = Judge.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @judge }
    end
  end

  # GET /judges/1/edit
  def edit
    @judge = Judge.find(params[:id])
  end

  # POST /judges
  # POST /judges.json
  def create
    @judge = Judge.new(params[:judge])

    respond_to do |format|
      if @judge.save
        format.html { redirect_to @judge, notice: 'Judge was successfully created.' }
        format.json { render json: @judge, status: :created, location: @judge }
      else
        format.html { render action: "new" }
        format.json { render json: @judge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /judges/1
  # PUT /judges/1.json
  def update
    @judge = Judge.find(params[:id])

    respond_to do |format|
      if @judge.update_attributes(params[:judge])
        format.html { redirect_to @judge, notice: 'Judge was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @judge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /judges/1
  # DELETE /judges/1.json
  def destroy
    @judge = Judge.find(params[:id])
    @judge.destroy

    respond_to do |format|
      format.html { redirect_to judges_url }
      format.json { head :no_content }
    end
  end
end
