#encoding: utf-8
class Admin::PlayersController < Admin::AreaController
  before_filter :find_player, :only => [:destroy, :update, :edit]
  before_filter :find_all_maps, :only => [:edit, :new]
  before_filter :find_all_users, :only => [:edit, :new]
  def index
    @players = Player.order("created_at DESC")
  end
  def new
    @player = Player.new
  end
  def create
    @player = Player.new(params[:player])
    if @player.save
      flash[:notice] = "Personnage créé avec succès!"
      redirect_to admin_players_path
    else
      flash[:error] = "Erreur lors de la création du personnage"
      render :new
    end
  end
  def edit
    
  end
  def update
    @player.attributes = params[:player]
    if @player.save
      flash[:notice] = "Personnage sauvegardé avec succès!"
      redirect_to admin_players_path
    else
      flash[:error] = "Erreur lors de la sauvegarde du personnage"
      render :edit
    end
  end
  def destroy
    if @player.delete
      flash[:notice] = "Personnage supprimé avec succès"
    else
      flash[:error] = "Erreur lors de la suppression du personnage"
    end
    redirect_to admin_players_path
  end
  private
  def find_player
    @player = Player.find params[:id]
  end
  def find_all_maps
    @maps = Map.all
  end
  def find_all_users
    @users = User.all
  end
end