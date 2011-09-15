#encoding: utf-8
class Admin::FieldsController < Admin::AreaController
  before_filter :find_field, :only => [:destroy, :update, :edit]
  before_filter :find_all_distant_fields, :only => [:new, :edit, :create, :update]
  def index
    @fields = Field.order("created_at DESC")
  end
  def new
    @field = Field.new
  end
  def create
    @field = Field.new(params[:field])
    if @field.save
      flash[:notice] = "Terrain créé avec succès!"
      redirect_to admin_fields_path
    else
      flash[:error] = "Erreur lors de la création du terrain"
      render :new
    end
  end
  def edit
    
  end
  def update
    @field.attributes = params[:field]
    if @field.save
      flash[:notice] = "Terrain sauvegardé avec succès!"
      redirect_to admin_fields_path
    else
      flash[:error] = "Erreur lors de la sauvegarde du terrain"
      render :edit
    end
  end
  def destroy
    if @field.delete
      flash[:notice] = "Terrain supprimé avec succès"
    else
      flash[:error] = "Erreur lors de la suppression du terrain"
    end
    redirect_to admin_fields_path
  end
  private
  def find_field
    @field = Field.find params[:id]
  end
  def find_all_distant_fields
    @distant_fields = Field.get_distant_fields_picture
    fields = Field.all.collect {|f| f.filename}
    @distant_fields = @distant_fields - fields
  end
end