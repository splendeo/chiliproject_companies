class CompaniesController < ApplicationController
  unloadable
  
  before_filter :require_admin, :except => [:index, :show]
  before_filter :get_compnay, :only => [:show, :edit, :update, :destroy]
  before_filter :fill_selects, :only => [:new, :create, :edit, :update]
  
  helper :attachments, :projects
  
  def index
    @companies = Company.all
  end
  
  def show
    @users = @company.users
    @projects = @company.projects.visible.all(:order => 'lft')
  end
  
  def new
    @company = Company.new
  end
  
  def create
    @company = Company.new(params[:company])
    if @company.save
      attachments = Attachment.attach_files(@company, params[:attachments]) if params[:attachments]
      flash[:notice] = "Successfully created company"
      redirect_to @company
    else
      render :action => 'new'
    end
  end
  
  def edit
  end
  
  def update
    params[:company][:user_ids] ||= []
    params[:company][:project_ids] ||= []
    if @company.update_attributes(params[:company])
      attachments = Attachment.attach_files(@company, params[:attachments]) if params[:attachments]
      flash[:notice] = "Successfully updated company"
      redirect_to @company
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @company.destroy
    flash[:notice] = "Successfully deleted company"
    redirect_to companies_url
  end
  
  private
  
  def fill_selects
    @users = User.active.all
    @projects = Project.active.all
  end
  
  def get_compnay
    @company = Company.find_by_identifier(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
