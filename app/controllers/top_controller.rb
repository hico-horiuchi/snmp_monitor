class TopController < ApplicationController
  def index
    redirect_to servers_path if current_user
  end
end
