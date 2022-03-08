class HomeController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?

  def index
  end

  def contact
  end

  def provinces
    provinces = Province.all
    render json: provinces
  end

  def districts
    province = Province.where(:code => params[:code]).first()
    districts = District.where(:parent_code => province.code).order(:code)
    render json: districts
  end

  def wards
    district = District.where(:code => params[:code]).first()
    wards = Ward.where(:parent_code => district.code).order(:code)
    render json: wards
  end
end
