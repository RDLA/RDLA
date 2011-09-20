class Player::PlayersController < ApplicationController
  def show
    
    @player = (Player.find params[:id] rescue Player.find session[:player_connected].to_i)
    
    render :partial => "game/info",  :locals => { :player => @player }
  end  
  def update_description
    player = Player.find session[:player_connected].to_i
    player.description = params[:description];
    player.save
    render  :nothing => true
  end
end