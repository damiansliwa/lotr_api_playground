module Api
  module V1
    class RealmsController < ApiController
      def index
        realms = Character.select(:realm).distinct.pluck(:realm)
        render json: realms, status: :ok
      end
    end
  end
end
