Jets.application.routes.draw do
  root "jets/public#show"
  get '/auth/auth0/callback', to: 'auth0#callback'
  get '/auth/failure', to: 'auth0#failure'
  get '/auth/logout', to: 'auth0#logout'
  get '/protected', to: 'application#test_protected_page'

  # The jets/public#show controller can serve static utf8 content out of the public folder.
  # Note, as part of the deploy process Jets uploads files in the public folder to s3
  # and serves them out of s3 directly. S3 is well suited to serve static assets.
  # More info here: https://rubyonjets.com/docs/extras/assets-serving/
  any "*catchall", to: "jets/public#show"
end
