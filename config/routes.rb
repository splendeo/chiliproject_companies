ActionController::Routing::Routes.draw do |map|
  map.resources :companies,
    :member => {
      :filter_available_members => :get, :delete_member => :post, :add_members => :post,
      :filter_available_projects => :get, :delete_project => :post, :add_projects => :post
    }
end
