require 'redmine'

Redmine::Plugin.register :chiliproject_companies do
  name 'Chiliproject Companies plugin'
  author 'Francisco de Juan'
  description 'Add companies pages to Chiliproject with links to users and projects related'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  
  menu :admin_menu, :companies, { :controller => 'companies', :action => 'index' }, :caption => 'Companies'
  
  permission :view_companies, :companies => :show
  permission :edit_companies, :companies => [:index, :new, :create, :edit, :update, :destroy]
end
