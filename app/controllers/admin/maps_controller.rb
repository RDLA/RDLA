#encoding: utf-8
class Admin::MapsController < Admin::AreaController
  before_filter :find_map, :only => [:destroy, :update, :edit]
  before_filter :find_all_fields, :only => [:new, :edit, :update, :create]
  def index
    @maps = Map.order("created_at DESC")
  end
  def new
    @map = Map.new
  end
  def create
    @map = Map.new(params[:map])
    if @map.save
      flash[:notice] = "Plan créé avec succès!"
      redirect_to admin_maps_path
    else
      flash[:error] = "Erreur lors de la création du plan"
      render :new
    end
  end
  def edit
    
  end
  def update
    @map.attributes = params[:map]
    if @map.save
      flash[:notice] = "Plan sauvegardé avec succès!"
      redirect_to admin_maps_path
    else
      flash[:error] = "Erreur lors de la sauvegarde du plan"
      render :edit
    end
  end
  def destroy
    if @map.delete
      flash[:notice] = "Plan supprimé avec succès"
    else
      flash[:error] = "Erreur lors de la suppression du plan"
    end
    redirect_to admin_maps_path
  end
  private
  def find_map
    @map = Map.find params[:id]
  end
  def find_all_fields
    @fields = Field.all
  end
end