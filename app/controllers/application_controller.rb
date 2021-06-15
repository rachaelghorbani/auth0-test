class ApplicationController < Jets::Controller::Base
  def test_protected_page
    render plain: session[:userinfo]
  end
end
