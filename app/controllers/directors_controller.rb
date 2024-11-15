class DirectorsController < ApplicationController
  
  def create
    #Paramters look like:
    #Parameters: {"query_name"=>"Neil", "query_dob"=>"1994-03-01", "query_bio"=>"Yay", "query_image"=>""}

    d = Director.new
    d.name = params.fetch("query_name")
    d.dob = params.fetch("query_dob")
    d.bio = params.fetch("query_bio")
    d.image = params.fetch("query_image")
    
    d.save 

    redirect_to("/directors")
    #Retrieve user's inputs from params
    #Create a record in the directors table 
    #Populate each column with the user input 
    #Redirect the user back to the /directors URL
  end
  
  
  def destroy
    the_id = params.fetch("an_id") #an_id from the get query in terminal that was ran

    matching_records = Director.where({ :id => the_id})

    the_director = matching_records.at(0)

    the_director.destroy

    redirect_to("/directors")
  end 


  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
