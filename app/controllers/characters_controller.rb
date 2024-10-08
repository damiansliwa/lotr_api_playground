class CharactersController < ApplicationController
  before_action :set_character, only: %i[ show update destroy ]

  def new
  end

  def edit
  end

  def index
    @characters = Character.all
    response = HTTParty.get('https://lotrapi.co/api/v1/characters')
    @response = JSON.parse(response.body)["results"]
    @names = @response.map { |character| character["name"] }
  end

  # GET /characters/1
  def show
    render json: @character
  end

  # POST /characters
  def create
    @character = Character.new(character_params)

    if @character.save
      render json: @character, status: :created, location: @character
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