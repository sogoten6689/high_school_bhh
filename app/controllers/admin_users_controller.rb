class AdminUsersController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @users = User.all
    @provinces = Province.all
    @ethnicities = Ethnicity.all
  end

  def show
    redirect_to  edit_basic_information_path(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    @provinces = Province.all
    @ethnicities = Ethnicity.all
  end

  def update
    @user = User.find(params[:id])
    puts edit_user_params[:full_name]
    puts edit_user_params[:gender]
    puts edit_user_params[:gender]
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

  private

  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity, :identification)
  end
end