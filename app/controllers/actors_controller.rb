class ActorsController < ApplicationController
  
  def create
    #Paramters look like:
    #Parameters: {"query_name"=>"Neil", "query_dob"=>"1994-03-01", "query_bio"=>"Yay", "query_image"=>""}

    a = Actor.new
    a.name = params.fetch("query_name")
    a.dob = params.fetch("query_dob")
    a.bio = params.fetch("query_bio")
    a.image = params.fetch("query_image")
    
    a.save 

    redirect_to("/actors")
    #Retrieve user's inputs from params
    #Create a record in the actor table 
    #Populate each column with the user input 
    #Redirect the user back to the /movies URL
  end
  
  
  def destroy
    the_id = params.fetch("an_id") #an_id from the get query in terminal that was ran

    matching_records = Actor.where({ :id => the_id})

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/actors")
  end 


  
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
