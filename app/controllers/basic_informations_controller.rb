class BasicInformationsController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @user = User.find(current_user.id)
    
    @user_contact = UserContact.where(user_id: current_user.id).first()

    @student_classess = StudentClass.where(user_id: @user.id)
    @relationship = Relationship.where(user_id: @user.id).first()

    @title_page = 'Thông tin cá nhân của tôi'
    @breadcrumbs = [
      ['Thông tin cá nhân của tôi', basic_informations_path],
    ]
  end

  def show

    @user = User.find(current_user.id)

    @user_contact = UserContact.where(user_id: current_user.id).first()

    @student_classess = StudentClass.where(user_id: @user.id)

    @title_page = 'Thông tin cá nhân của tôi'
    @breadcrumbs = [
      ['Thông tin cá nhân của tôi', basic_informations_path],
    ]
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
    else
      @provinces = Province.all
      @ethnicities = Ethnicity.all
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_user_contact
    @user = User.find(params[:id])
    @user_contact = UserContact.where(user_id: params[:id]).first()
    @provinces = Province.order(:code).all

    @household_districts = District.where(parent_code: @user_contact.household_province).order(:code)
    @household_wards = Ward.where(parent_code: @user_contact.household_district).order(:code)

    @contact_districts = District.where(parent_code: @user_contact.contact_province).order(:code)
    @contact_wards = Ward.where(parent_code: @user_contact.contact_district).order(:code)

    @title_page = 'Cập nhật thông tin liên lạc'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
      ['Cập nhật thông tin liên lạc', edit_user_contact_path]
    ]
  end

  def update_user_contact
    @user = User.find(params[:id])
    @user_contact = UserContact.where(user_id: params[:id]).first()
    if @user_contact.update(edit_user_contact_params)
      redirect_to  edit_admin_user_path(params[:id])
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

  def edit_relationship
    @user = User.find(params[:id])
    @relatioship = Relationship.where(user_id: params[:id]).first()
    if @relatioship.nil?
      @relatioship = Relationship.create([user_id: params[:id]]).first()
    end

    @title_page = 'Cập nhật thông tin gia đình'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
      ['Cập nhật thông tin gia đình', edit_relationship_path]
    ]
  end

  def update_relationship
    @user = User.find(params[:id])
    @relatioship = Relationship.where(user_id: params[:id]).first()
    if @relatioship.update(edit_relationship_params)
      redirect_to  edit_admin_user_path(params[:id])
    else
      @title_page = 'Cập nhật thông tin gia đình'
      @breadcrumbs = [
        ['Thông tin cá nhân', basic_informations_path],
        ['Cập nhật thông tin gia đình', edit_relationship_path]
      ]
      render :edit, status: :unprocessable_entity
    end
  end

  def edit_password
    @user = current_user
    @title_page = 'Đổi mật khẩu'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
      ['Đổi mật khẩu', edit_password_basic_informations_path]
    ]
  end

  def update_password
    @user = User.find(current_user.id)
    # current_password = params[:user][:current_password]
    # user = User.authentication_keys(@user.email, current_password)

    if @user.update_with_password(user_password_params)
      # Add an error stating that the current password is incorrect

      sign_in @user, bypass: true
      redirect_to basic_informations_path, {notice: 'Cập nhật mật khẩu thành công!'}
    else
      redirect_to edit_password_basic_informations_path(current_user), {alert: 'Mật khẩu hiện tại không đúng!'}
    end
    # if user.update_with_password(user_password_params)
    #   # Sign in the user by passing validation in case their password changed
    #   sign_in @user, :bypass => true
    #   redirect_to basic_informations_path, {alert: 'ok'}
    # else
    #   render "edit_password"
    # end
  end

  private

  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity, :identification)
  end

  def edit_user_contact_params
    params.require(:user_contact).permit( :household_province, :household_district, :household_ward, :household_address,
                                          :contact_province, :contact_district, :contact_ward, :contact_address, :phone_number)
  end

  def edit_relationship_params
    params.require(:relationship).permit( :father_name, :father_year, :father_career, :father_phone, :father_address,
                                          :mother_name, :mother_year, :mother_career, :mother_phone, :mother_address,
                                          :guardian_name, :guardian_year, :guardian_career, :guardian_phone, :guardian_address)
  end

  def user_password_params
    params.require(:user).permit(:current_password, :password, :password_confirmation)
  end

end
