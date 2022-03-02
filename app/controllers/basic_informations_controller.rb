class BasicInformationsController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @user = User.find(current_user.id)

    if (@user.province.nil? || @user.birthday.nil?)
      redirect_to edit_basic_information_path(current_user.id), {alert: 'Vui lòng cập nhật thong tin cơ bản để truy cập!'}
    end

    @user_contact = UserContact.where(:user_id => current_user.id).first()
    if (@user_contact.nil? || @user_contact.household_province.nil? || @user_contact.household_ward.nil? || @user_contact.household_district.nil? || @user_contact.contact_province.nil? || @user_contact.contact_district.nil? || @user_contact.contact_address.nil?)
      redirect_to edit_user_contact_path(current_user.id)
    end
    @province = Province.where(:code => @user.province).first()

    @household_province = Province.where(:code => @user_contact.household_province).first()
    @contact_province = Province.where(:code => @user_contact.contact_province).first()

    @household_district = District.where(:code => @user_contact.household_district).first()
    @contact_district = District.where(:code => @user_contact.contact_district).first()

    @household_ward = Ward.where(:code => @user_contact.household_ward).first()
    @contact_ward = Ward.where(:code => @user_contact.contact_ward).first()
    if (@user.ethnicity == 0)
      @ethnicity_name = @user.another_ethnicity
    else
      @ethnicity = Ethnicity.where(:id => @user.ethnicity).first()
      @ethnicity_name = @ethnicity.nil? ? '' : @ethnicity.name
    end

    @title_page = 'Thông tin cá nhân'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
    ]
  end

  def show
    redirect_to  basic_informations_path
  end

  def edit
    @user = User.find(params[:id])
    @provinces = Province.all
    @ethnicities = Ethnicity.all

    @title_page = 'Cập nhật thông tin cơ bản'
    @breadcrumbs = [
      ['Cập nhật thông tin cơ bản', basic_informations_path],
    ]
  end

  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to  basic_informations_path

      # redirect_to  edit_basic_information_path(params[:id])
      # if current_user.role == 4
      #   redirect_to  basic_informations_path
      # else
      #   redirect_to  basic_information_path(params[:id])
      # end
    else
      @provinces = Province.all
      @ethnicities = Ethnicity.all
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_user_contact
    @user = User.find(params[:id])
    @user_contact = UserContact.where(:user_id => params[:id]).first()
    @provinces = Province.all

    @household_districts = District.where(:province_code => @user_contact.household_province)
    @household_wards = Ward.where(:district_code => @user_contact.household_district)

    @contact_districts = District.where(:province_code => @user_contact.contact_province)
    @contact_wards = Ward.where(:district_code => @user_contact.contact_district)

    @title_page = 'Cập nhật thông tin liên lạc'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
      ['Cập nhật thông tin liên lạc', edit_user_contact_path]
    ]
  end


  def update_user_contact
    @user = User.find(params[:id])
    @user_contact = UserContact.where(:user_id => params[:id]).first()
    if @user_contact.update(edit_user_contact_params)
      redirect_to  basic_informations_path

      # redirect_to  edit_basic_information_path(params[:id])
      # if current_user.role == 4
      #   redirect_to  basic_informations_path
      # else
      #   redirect_to  basic_information_path(params[:id])
      # end
    else
      @provinces = Province.all
      @title_page = 'Cập nhật thông tin liên lạc'
      @breadcrumbs = [
        ['Thông tin cá nhân', basic_informations_path],
        ['Cập nhật thông tin liên lạc', edit_user_contact_path]
      ]
      render :edit, status: :unprocessable_entity
    end
  end
  private

  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity, :identification)
  end

  def edit_user_contact_params
    params.require(:user_contact).permit( :household_province, :household_district, :household_ward, :household_address,
                                          :contact_province, :contact_district, :contact_ward, :contact_address, :phone_number)
  end
end
