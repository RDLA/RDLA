#encoding: utf-8
class Admin::FeedbacksController < Admin::AreaController
  before_filter :find_feedback, :only => [:destroy, :update, :edit]
  before_filter :find_all_users, :only => [:edit, :new]
  def index
    @feedbacks = Feedback.order("priority DESC")
  end
  def new
    @feedback = Feedback.new
  end
  def create
    @feedback = Feedback.new(params[:feedback])
    if @feedback.save
      flash[:notice] = "Demande créé avec succès!"
      redirect_to admin_feedbacks_path
    else
      flash[:error] = "Erreur lors de la création de la demande"
      render :new
    end
  end
  def edit
    
  end
  def update
    @feedback.attributes = params[:feedback]
    if @feedback.save
      flash[:notice] = "Demande sauvegardée avec succès!"
      redirect_to admin_feedbacks_path
    else
      flash[:error] = "Erreur lors de la sauvegarde de la demande"
      render :edit
    end
  end
  def destroy
    if @feedback.delete
      flash[:notice] = "Demande supprimée avec succès"
    else
      flash[:error] = "Erreur lors de la suppression de la demande"
    end
    redirect_to admin_feedbacks_path
  end
  private
  def find_feedback
    @feedback = Feedback.find params[:id]
  end
    def find_all_users
    @users = User.all
  end
end