class CompaniesController < ApplicationController
  unloadable

  before_filter :require_admin, :except => [:index, :show]
  before_filter :get_company, :only => [:show, :edit, :update, :destroy, :delete_member, :list_members]
  before_filter :fill_selects, :only => [:new, :create, :edit, :update]

  helper :projects, :custom_fields

  def index
    @companies = Company.all
    @custom_fields = CompanyCustomField.all(:order => 'position ASC')
    @settings = Setting.plugin_chiliproject_companies
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
      render_attachment_warning_if_needed(@company)
      flash[:notice] = t(:notice_successful_create)
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
      render_attachment_warning_if_needed(@company)
      flash[:notice] = t(:notice_successful_update)
      redirect_to @company
    else
      render :action => 'edit'
    end
  end

  def destroy
    @company.destroy
    flash[:notice] = t(:notice_cuscessful_delete)
    redirect_to companies_url
  end

  def delete_member
    member = @company.users.find(params[:member_id])
    @company.users.delete(member)
    redirect_to :controller => 'companies', :action => 'list_members', :id => @company
  end

  def list_members
    render :partial => 'members'
  end

  private

  def fill_selects
    @users = User.active.all
    @projects = Project.active.all
  end

  def get_company
    @company = Company.find_by_identifier(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
