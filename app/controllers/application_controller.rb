class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  # acts_as_token_authentication_handler_for User, fallback_to_devise: false
  # skip_before_filter :verify_authenticity_token
end
