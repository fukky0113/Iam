class StaticPagesController < ApplicationController
  before_action :logged_out_user, only: [:home]

  def home
  end
end
