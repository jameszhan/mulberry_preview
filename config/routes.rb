Rails.application.routes.draw do
  
  get 'preview/:type/:id' => 'preview#index', as: :preview
  get 'download/:type/:id' => 'preview#download', as: :download
  post 'open' => 'preview#open'
  
end
