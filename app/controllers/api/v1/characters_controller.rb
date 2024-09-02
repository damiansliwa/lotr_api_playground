module Api
	module V1
		class CharactersController < ApiController
		  before_action :set_character, only: %i[ show update destroy ]

		  rescue_from NoMethodError do |e|
		  	render json: { status: "500", error: "Method not found." }, status: :internal_server_error
		  end

		  # GET /characters
		  def index
		    @characters = Character.all

		    if params[:name].present?
		    	@characters = @characters.where("name LIKE ?", "%#{params[:name]}%")
		    elsif params[:race].present?
		    	@characters = @characters.where("race LIKE ?", "%#{params[:race]}%")
	    	elsif params[:realm].present?
		    	@characters = @characters.where("realm LIKE ?", "%#{params[:realm]}%")
		    end

		    render json: @characters
		  end

		  # GET /characters/1
		  def show
		    render json: @character
		  end

		  # POST /characters
		  def create
		    @character = Character.new(character_params)

		    if @character.save
		      render json: @character, status: :created, location: url_for([:api, :v1, @character])
		    else
		      render json: @character.errors, status: :unprocessable_entity
		    end
		  end

		  # PATCH/PUT /characters/1
		  def update
		    if @character.update(character_params)
		      render json: @character
		    else
		      render json: @character.errors, status: :unprocessable_entity
		    end
		  end

		  # DELETE /characters/1
		  def destroy
		    @character.destroy!
		  end

		  private
		    # Use callbacks to share common setup or constraints between actions.
		    def set_character
		      @character = Character.find(params[:id])
		    end

		    # Only allow a list of trusted parameters through.
		    def character_params
		      params.require(:character).permit(:name, :race, :realm)
		    end
		end
	end
end