class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  def index
    redirect_to articles_path
  end
end
