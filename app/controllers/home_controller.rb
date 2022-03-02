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
    districts = District.where(:province_code => province.code)
    render json: districts
  end

  def wards
    district = District.where(:code => params[:code]).first()
    wards = Ward.where(:district_code => district.code)
    render json: wards
  end
end
