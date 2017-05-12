Rails.application.routes.draw do
  get '/hint', to: 'homework#hint'
  get '/dates', to: 'homework#dates'
  post '/poll', to: 'homework#poll'
  get 'state_info', to: 'homework#state_info'
end
