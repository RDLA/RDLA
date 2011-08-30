#encoding: utf-8
class Admin::UsersController < Admin::AreaController
  before_filter :manage_password, :only => [:create, :update]
  before_filter :find_user, :only => [:destroy, :update, :edit]
  def index
    @users = User.order("created_at DESC")
  end
  def new
    @user = User.new
  end
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Compte créé avec succès!"
      redirect_to admin_users_path
    else
      flash[:error] = "Erreur lors de la création du compte"
      render :new
    end
  end
  def edit
    
  end
  def update
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Compte sauvegardé avec succès!"
      redirect_to admin_users_path
    else
      flash[:error] = "Erreur lors de la sauvegarde du compte"
      render :edit
    end
  end
  def destroy
    if current_user != @user && @user.delete
      flash[:notice] = "Plan supprimé avec succès"
    else
      flash[:error] = "Erreur lors de la suppression du plan"
    end
    redirect_to admin_users_path
  end
  private
  def manage_password
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end
  end
  def find_user
    @user = User.find params[:id]
  end
end