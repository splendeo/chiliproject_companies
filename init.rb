require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :chiliproject_companies do
  require_dependency 'chiliproject_companies/patches/user_patch'
  require_dependency 'chiliproject_companies/patches/project_patch'
  require_dependency 'chiliproject_companies/patches/custom_fields_helper_patch'
  
  require_dependency 'chiliproject_companies/hooks'
end

Redmine::Plugin.register :chiliproject_companies do
  name 'Chiliproject Companies plugin'
  author 'Francisco de Juan'
  description 'Add companies pages to Chiliproject with links to users and projects related'
  version '0.1.0'
  url 'https://github.com/splendeo/chiliproject_companies'
  author_url 'http://www.splendeo.es'
  
  settings  :partial => 'settings/companies',
            :default => {
              'top_text' => '',
              'bottom_text' => ''
            }
  
  menu :admin_menu, :companies, { :controller => 'settings', :action => 'plugin', :id => 'chiliproject_companies' }, :caption => 'Companies'
  menu :top_menu, :companies, { :controller => 'companies', :action => 'index' }, :caption => 'Companies', :after => :projects
end
