class StudentClassesController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @user = User.find(current_user.id)
    @provinces = Province.all
    @ethnicities = Ethnicity.all
  end

  def show
    redirect_to  edit_basic_information_path(params[:id])
  end

  def create
    @student_class = StudentClass.new(student_class_params)
    if @student_class.save
      redirect_to  edit_admin_user_path(@student_class.user_id)
    end
  end

  def edit
    @user = User.find(params[:id])
    @provinces = Province.all
    @ethnicities = Ethnicity.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to  edit_basic_information_path(params[:id])
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

  def destroy
    @student_class = StudentClass.find(params[:id])
    user_id = @student_class.user_id
    @student_class.delete
    redirect_to  edit_admin_user_path(user_id)
  end

  private

  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity, :identification)
  end

  def student_class_params
    params.require(:student_class).permit(:class_name, :grade, :student_class_code, :year, :user_id)
  end
end
