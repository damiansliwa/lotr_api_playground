class HomeController < ApplicationController
  def index
    message = {
      app: "The Lord of The Rings API Playground application",
      version: "1.0.0.",
      date: Time.now
    }
    render json: message
  end
end
