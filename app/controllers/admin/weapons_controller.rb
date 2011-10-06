#encoding: utf-8
class Admin::WeaponsController < Admin::AreaController
  before_filter :find_weapon, :only => [:destroy, :update, :edit]
  
  def index
    @weapons = Item::Weapon.order("created_at DESC")
  end
  def new
    @weapon = Item::Weapon.new
  end
  def create
    @weapon = Item::Weapon.new(params[:weapon])
    if @weapon.save
      flash[:notice] = "Arme créé avec succès!"
      redirect_to admin_weapons_path
    else
      flash[:error] = "Erreur lors de la création de l'arme"
      render :new
    end
  end
  def edit
    
  end
  def update
    @weapon.attributes = params[:weapon]
    if @weapon.save
      flash[:notice] = "Arme sauvegardé avec succès!"
      redirect_to admin_weapons_path
    else
      flash[:error] = "Erreur lors de la sauvegarde de l'arme"
      render :edit
    end
  end
  def destroy
    if @weapon.delete
      flash[:notice] = "Arme supprimé avec succès"
    else
      flash[:error] = "Erreur lors de la suppression de l'arme"
    end
    redirect_to admin_weapons_path
  end
  private
  def find_weapon
    @weapon = Item::Weapon.find params[:id]
  end

end