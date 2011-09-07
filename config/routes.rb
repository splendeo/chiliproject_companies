if defined? map
  map.resources :companies
else
  ActionController::Routing::Routes.draw do |map|
    map.resources :companies
  end
end
