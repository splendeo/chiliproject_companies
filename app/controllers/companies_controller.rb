class CompaniesController < ApplicationController
  unloadable

  before_filter :require_admin, :except => [:index, :show]
  before_filter :get_company_by_identifier, :except => [:index, :new, :create]
  before_filter :get_users, :only => [:new, :create, :edit, :update, :show, :members]
  before_filter :get_projects, :only => [:new, :create, :edit, :update, :show, :projects]

  helper :projects, :custom_fields

  def index
    @companies = Company.all
    @custom_fields = CompanyCustomField.all(:order => 'position ASC')
    @settings = Setting.plugin_chiliproject_companies
  end

  def show
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
    member = User.find(params[:member_id])
    @company.users.delete(member)
    get_users
    update_with_javascript('members')
  end

  def members
    render :partial => 'members'
  end

  def add_members
    member_ids = params[:member_ids]
    @company.user_ids += member_ids
    get_users
    update_with_javascript('members')
  end

  private

  def get_users
    @users = @company.users
    @available_members = User.active.find(:all, :limit => 100, :order => 'login, lastname ASC') - @users
  end

  def get_projects
    @projects = @company.projects
    @available_projects = Project.active.find(:all, :limit => 100, :order => 'lft') - @projects
  end

  def update_with_javascript(id)
    render(:update) { |page|
      page.replace_html id, :partial => id
      page << 'hideOnLoad()'
    }
  end

  def get_company_by_identifier
    @company = Company.find_by_identifier(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
