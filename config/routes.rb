Rails.application.routes.draw do
  root 'home#top'
  post '/callback' => 'linebot#callback'
  namespace 'api' do
    namespace 'v1' do
      resources :messages
    end
  end
end
