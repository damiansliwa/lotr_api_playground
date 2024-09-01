module Api
	module V1
		class ExternalApiController < ApiController
			require 'httparty'

			def fetch_character
				character_id = params[:id]
				response = HTTParty.get("https://lotrapi.co/api/v1/characters/#{character_id}")

				if response.success?
					character_name = JSON.parse(response.body)["name"]
					character = Character.find_by(name: character_name)
					if character
						render json: { 
							message: "Yaaay! Character was found on local database!",
							name: character_name,
							race: character.race,
							realm: character.realm
						}
						status: :ok
					else
						render json: { 
							message: "Nay! :( This character doesn't exist on local database.",
							name: character_name
						}
						status: :ok
					end
				else
					render json: { error: "Failed to fetch character with id #{character_id}" }, status: :not_found
				end
			end
		end
	end
end