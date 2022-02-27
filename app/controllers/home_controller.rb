class HomeController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?

  def index
  end

  def contact
  end
end
