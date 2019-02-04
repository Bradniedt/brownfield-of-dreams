class WelcomeController < ApplicationController
  def index
    params[:tag] ? @tutorials = Tutorial.tagged(current_user, params) : @tutorials = Tutorial.untagged(current_user, params)
  end
end
