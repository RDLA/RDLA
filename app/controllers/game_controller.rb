class GameController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  def index
    #Select Players of User connected
    @player_connected = @user.players.first
    @map = @player_connected.map
    
    @players = @map.get_players(@player_connected.posx, @player_connected.posx)
    
  end
  
  private
  def get_user
      @user = current_user unless current_user.blank?
  end

end
