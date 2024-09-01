module Api
	module V1
		class ExternalApiController < ApiController
			require 'httparty'

			def fetch_character
				character_id = params[:id]
				response = HTTParty.get("https://lotrapi.co/api/v1/characters/#{character_id}")

				if response.success?
					ext_character_data = JSON.parse(response.body)
					ext_character_name = ext_character_data["name"]
					ext_character_race = ext_character_data["race"]
					ext_race_url = HTTParty.get(ext_character_race)
					ext_race_name = JSON.parse(ext_race_url.body)["name"]
					ext_character_realm = ext_character_data["realm"]
					ext_realm_url = HTTParty.get(ext_character_realm)
					ext_realm_name = JSON.parse(ext_realm_url.body)["name"]
			
					character = Character.find_by(name: ext_character_name)
					if character
						render json: { 
							message: "This character already exists on local database! See details below:",
							name: character.name,
							race: character.race,
							realm: character.realm
						},
						status: :ok
					else
						imported_character = Character.create(
							name: ext_character_data["name"],
							race: ext_race_name,
							realm: ext_realm_name
							)
						render json: { 
							message: "New character has been imported to the local database!",
							name: imported_character.name,
							race: imported_character.race,
							realm: imported_character.realm
						},
						status: :ok
					end
				else
					render json: { error: "Failed to fetch character with id #{character_id}" }, status: :not_found
				end
			end
		end
	end
end