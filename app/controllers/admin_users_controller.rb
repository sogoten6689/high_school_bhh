class AdminUsersController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  before_action :is_admin?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    @users = User.all


    @title_page = 'Danh Sách Tài khoản'
    @breadcrumbs = [
      ['Danh Sách Tài khoản', admin_users_path],
    ]
  end

  def show
    @user = User.find(params[:id])
    @user_contact = UserContact.where(:user_id => params[:id]).first()
    @student_classess = StudentClass.where(:user_id => @user.id)
    @title_page = @user.name
    @breadcrumbs = [
      ['Danh Sách Tài khoản', admin_users_path],
      [@user.name, admin_user_path(@user.id)]
    ]
  end

  def import_student
  end

  def update_import_student

    # files có thể ở dạng files hoặc là path của files đều được xử lý chính xác bởi method open
    # puts params[:files]
    spreadsheet = Roo::Spreadsheet.open params[:file]
    # lấy cột header (column name)
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).each do |i|
      # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
      # row = [header, spreadsheet.row(i)].transpose.to_h
      row = spreadsheet.row(i)
      if (row[1].nil? || row[2].nil? || row[3].nil?)
      else
        password = row[4].nil? ? '123456' : row[4]
        name = row[1].to_s.split(' ').last
        User.create(:full_name => row[1], :name => name, :email => row[2], :student_code => row[3], :password => password)
        # @user = User.where(:student_code =>  row[3]).first();
        # @student_class = StudentClass.where(:user_id => @user.id).first_or_create(:user_id => @user.id);
        # @student_class.update(:class_name => row[5], :grade => row[6], :student_class_code => row[7])
        # redirect_to admin_users_path

      end
    end
    redirect_to admin_users_path
  end

  def import_student_class
  end

  def update_import_student_class

    # files có thể ở dạng files hoặc là path của files đều được xử lý chính xác bởi method open
    # puts params[:files]
    spreadsheet = Roo::Spreadsheet.open params[:file]
    # lấy cột header (column name)
    header = spreadsheet.row 1
    (2..spreadsheet.last_row).each do |i|
      # lấy ra bản ghi và biến đổi thành hash để có thể tạo record tương ứng
      # row = [header, spreadsheet.row(i)].transpose.to_h
      row = spreadsheet.row(i)
      puts row[1]
      if !(row[1].nil?)
        @user = User.where(:student_code => row[1]).first()
        puts @user.nil?
        unless @user.nil?
          @student_class = StudentClass.create(:user_id => @user.id, :class_name => row[2], :grade => row[3], :student_class_code => row[4], :year => row[5])
        end
      end
    end
    redirect_to admin_users_path
  end
  
  def students_sample
    send_file Rails.root.join("app/assets/files/students.csv"), type: 'csv'
  end

  def student_classes_sample
    send_file Rails.root.join("app/assets/files/classes.csv"), type: 'csv'
  end

  def edit
    @user = User.find(params[:id])
    @provinces = Province.all
    @ethnicities = Ethnicity.all

    @relatioship = Relationship.where(:user_id => params[:id]).first()
    @user_contact = UserContact.where(:user_id => params[:id]).first()

    @household_districts = District.where(:parent_code => @user_contact.household_province).order(:code)
    @household_wards = Ward.where(:parent_code => @user_contact.household_district).order(:code)

    @contact_districts = District.where(:parent_code => @user_contact.contact_province).order(:code)
    @contact_wards = Ward.where(:parent_code => @user_contact.contact_district).order(:code)
    @user_classes = StudentClass.where(:user_id => @user.id).order(created_at: :desc)
    @student_class = StudentClass.new

    @title_page = @user.name
    @breadcrumbs = [
      ['Danh Sách Tài Khoản', admin_users_path],
      [@user.name, edit_admin_user_path(@user.id)]
    ]
  end

  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to  edit_admin_user_path(params[:id])
    else
      @provinces = Province.all
      @ethnicities = Ethnicity.all
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_student
    student_codes = params[:student_codes]
    user_ids = User.where(:student_code => student_codes).select(:id).to_a
    UserContact.where(:user_id =>  user_ids).delete_all
    Relationship.where(:user_id =>  user_ids).delete_all
    User.where(:student_code => student_codes).delete_all
    redirect_to  admin_users_path
  end

  def destroy
    @user_contact = UserContact.where(:user_id =>  params[:id]).first()
    @user_contact.delete unless @user_contact.nil?
    @student_class = StudentClass.where(:user_id =>  params[:id]).delete_all
    @relationship = Relationship.where(:user_id =>  params[:id]).first()
    @relationship.delete unless @relationship.nil?
    @user = User.find(params[:id])
    @user.delete
    redirect_to  admin_users_path
  end

  private


  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity, :identification, :role)
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
end
