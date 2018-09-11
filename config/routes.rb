Rails.application.routes.draw do

  get 'index/api'
  root 'index#crawler'
  get 'index/crawler'
  get 'index/image_api'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
