class ElectiveSubjectsController < ApplicationController
    include ApplicationHelper
    before_action :is_signed_in?
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
        
    end
end