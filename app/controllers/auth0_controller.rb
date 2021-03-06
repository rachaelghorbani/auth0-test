# frozen_string_literal: true

class Auth0Controller < ApplicationController
  def callback
    # Stores all the user info that came from Auth0 and IdP
    session[:userinfo] = request.env['omniauth.auth']

    # Redirect to Arist Dashboard
    redirect_to '/protected'
  end

  def failure
    # Redirect to Failure Page
    @error_msg = request.params['message']
    # Raise the error message instead of redirecting
    raise "Auth0 Error: #{request.params['message']}"
  end

  def logout
    session[:userinfo], session[:session_id], @current_user = nil
    redirect_to logout_url.to_s
  end

  private
  
  def logout_url
    domain = ENV['AUTH0_DOMAIN']
    client_id = ENV['AUTH0_CLIENT_ID']
    request_params = {
      returnTo:  root_url,
      client_id: client_id
    }
    URI::HTTPS.build(host: domain, path: '/v2/logout', query: to_query(request_params))
  end

  def to_query(hash)
    hash.map { |k, v| "#{k}=#{CGI.escape(v)}" unless v.nil? }.reject(&:nil?).join('&')
  end
end
