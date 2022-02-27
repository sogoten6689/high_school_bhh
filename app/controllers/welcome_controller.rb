class WelcomeController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?

end
