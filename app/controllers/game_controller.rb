class GameController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  def index
    #Select Players of User connected
     if session[:player_connected].blank?
        @player_connected = @user.players.first
        session[:player_connected] = @player_connected.id
     else
       @player_connected = Player.find session[:player_connected].to_i
     end
     
    @map = @player_connected.map
    
    @players = @map.get_players(@player_connected.posx, @player_connected.posy)
    @fields = @map.get_fields(@player_connected.posx, @player_connected.posy)
    @buildings = @map.get_buildings(@player_connected.posx, @player_connected.posy)
  end
  
  private
  def get_user
      @user = current_user unless current_user.blank?
  end

end
