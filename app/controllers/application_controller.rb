class ApplicationController < ActionController::Base
  # include ApplicationHelper
  # before_action :is_signed_in?

  def provinces
    provinces = Province.all
    render json: provinces
  end

  def districts
    province = Province.where(:code => params[:code]).first()
    districts = District.where(:province_id => province.id)
    render json: districts
  end

  def wards
    district = District.where(:code => params[:code]).first()
    wards = Ward.where(:district_id => district.id)
    render json: wards
  end

end
