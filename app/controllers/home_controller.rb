class HomeController < ApplicationController
  def index
    redirect_to game_path
  end
end