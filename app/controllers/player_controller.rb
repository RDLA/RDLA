class PlayerController < ApplicationController
  respond_to :json
  def current_position
   @player = Player.find session[:player_connected].to_i
   
    respond_with(@player)
  end
end