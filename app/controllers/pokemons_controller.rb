class PokemonsController < ApplicationController

  def index
    # function loads all pokemons of national region because the
    # pokedex national ID is 1
    begin
      url = Rails.configuration.api_url+'pokedex/1'
      response = RestClient.get url
      if response.code == 200
        # if response was successfully parse JSON
        response = JSON.parse(response)
        # get the values of all pokemons in the national region and paginate
        @pokemons = response["pokemon_entries"].paginate(:page => params[:page], :per_page => 12)
      else
        # if response code isn't succed, set a message to the user and show the view
        flash[:error] = 'Ocurrió un error en la consulta hacia pokeapi. Por favor, inténtalo nuevamente'
      end
    rescue
      #if an exception appears, set a message to the user and show the view
      flash[:error] = 'Ocurrió un error en la consulta hacia pokeapi. Por favor, inténtalo nuevamente'
    end
  end

  def show
    begin
      err_msg = 'Ocurrió un error en la consulta hacia pokeapi. Por favor, inténtalo nuevamente'

      # Default image and text if an error occurs
      @name = "MissingNo"
      @front_url = Rails.configuration.misigno_image
      @back_url = Rails.configuration.misigno_image

      @height = "???"
      @weight = "???"
      @abilities = ""
      @moves = ""

      # Make request
      id = params["id"]
      url = Rails.configuration.api_url + "pokemon/#{id}/"
      response = RestClient.get url

      # Data is response is successfull
      if response.code == 200
        response = JSON.parse(response)

        @name = response["name"].capitalize
        @front_url = Rails.configuration.image_base + "#{id}.png"
        @back_url = Rails.configuration.image_back_base + "#{id}.png"

        @height = "%0.3f m." % [response["height"] * 0.1]
        @weight = "%0.3f Kg." % [response["weight"] * 0.01]

        abilities = response["abilities"].collect{|x| x["ability"]["name"]}
        moves = response["moves"].collect{|x| x["move"]["name"]}

        @abilities = abilities.sort.join(", ")
        @moves = moves.sort.join(", ")

      else
        flash[:error] = err_msg
      end
  rescue
    flash[:error] = err_msg
  end


  end
end
