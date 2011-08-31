class GameController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_user
  def index
    #Select Players of User connected
    @player = @user.players.first
    @map = @player.map
  end
  
  private
  def get_user
      @user = current_user unless current_user.blank?
  end

end
