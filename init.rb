require 'redmine'
require 'dispatcher'

Dispatcher.to_prepare :chiliproject_companies do
  require_dependency 'user_patch'
  
end

Redmine::Plugin.register :chiliproject_companies do
  name 'Chiliproject Companies plugin'
  author 'Francisco de Juan'
  description 'Add companies pages to Chiliproject with links to users and projects related'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  menu :admin_menu, :companies, { :controller => 'companies', :action => 'index' }, :caption => 'Companies'
  menu :top_menu, :companies, { :controller => 'companies', :action => 'index' }, :caption => 'Companies', :after => :projects
end
