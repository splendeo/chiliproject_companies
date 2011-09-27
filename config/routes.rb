ActionController::Routing::Routes.draw do |map|
  map.resources :companies, :member => { :delete_member => :post, :list_members => :get }
end
