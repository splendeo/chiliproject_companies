require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :chiliproject_companies do
  require_dependency 'principal'
  require_dependency 'user'
  require_dependency 'chiliproject_companies/patches/user_patch'
  User.send(:include, ChiliprojectsCompanies::Patches::UserPatch)

  require_dependency 'project'
  require_dependency 'chiliproject_companies/patches/project_patch'
  Project.send(:include, ChiliprojectsCompanies::Patches::ProjectPatch)

  require_dependency 'acts_as_customizable'
  require_dependency 'custom_fields_helper'
  require_dependency 'chiliproject_companies/patches/custom_fields_helper_patch'
  CustomFieldsHelper.send(:include, ChiliprojectsCompanies::Patches::CustomFieldsHelperPatch)

  require_dependency 'projects_helper'
  require_dependency 'chiliproject_companies/patches/projects_helper_patch'
  CustomFieldsHelper.send(:include, ChiliprojectsCompanies::Patches::ProjectsHelperPatch)

  require_dependency 'chiliproject_companies/hooks'
end

Redmine::Plugin.register :chiliproject_companies do
  name 'Chiliproject Companies plugin'
  author 'Francisco de Juan'
  description 'Add companies pages to Chiliproject with links to users and projects related'
  version '0.2.0'
  url 'https://github.com/splendeo/chiliproject_companies'
  author_url 'http://www.splendeo.es'

  settings  :partial => 'settings/companies',
            :default => {
              'top_text' => '',
              'bottom_text' => '',
              'auto_calculate_proyects' => false
            }

  menu :admin_menu, :companies, { :controller => 'settings', :action => 'plugin', :id => 'chiliproject_companies' }, :caption => 'Companies'
  menu :top_menu, :companies, { :controller => 'companies', :action => 'index' }, :caption => 'Companies', :after => :projects

  permission :view_companies, :companies => [:show, :index]
end
