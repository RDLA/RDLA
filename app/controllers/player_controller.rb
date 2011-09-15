class PlayerController < ApplicationController
  respond_to :json, :html, :css
  def current_position
    @player = Player.find session[:player_connected].to_i
   
    respond_with(@player)
  end
  def update_position
    #Select Players of User connected
    if session[:player_connected].blank?
      @player_connected = @user.players.first
      session[:player_connected] = @player_connected.id
    else
      @player_connected = Player.find session[:player_connected].to_i
    end

    
    #TODO Check with A* Algorithm if the player can move
    if(!params[:x].blank? && !params[:y].blank? )
        @player_connected.posx = params[:x]
        @player_connected.posy = params[:y]
        @player_connected.save
        
    end
    
       
    @players =  @player_connected.map.get_players(@player_connected.posx, @player_connected.posy)
    @fields =  @player_connected.map.get_fields(@player_connected.posx, @player_connected.posy)
    
    
    
    render :layout => false
  end
  def field_css
    @fields = Field.all
    render :layout => false
  end
end