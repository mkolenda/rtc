class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  def logged_in_author
    # Simple way to get logged in author
    Author.first ? Author.first : Author.create(:name => 'Abe Lincoln')
  end
end
