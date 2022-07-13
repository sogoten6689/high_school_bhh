require 'app_utils'
require 'excel_utils'

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
    @relationship = Relationship.where(:user_id =>  params[:id]).first()
    @secondary_school_user = SecondarySchoolUser.where(user_id: @user.id).first()

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
    send_file Rails.root.join('app/assets/files/students.csv'), type: 'csv'
  end

  def student_classes_sample
    send_file Rails.root.join('app/assets/files/classes.csv'), type: 'csv'
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

    @religions = [['Không', 0], ['Công Giáo', 1],['Phật Giáo', 2], ['Hòa Hảo', 3],['Tin Lành', 4], ['Hồi Giáo', 5], ['Khác', 6]]
    @identification_types = [['Chưa có CCCD/CMND', 0], ['Đã có CMND', 1],['Đã có CCCD thường', 2], ['Đã có CCCD gắn chíp', 3]]

    @title_page = @user.name
    @breadcrumbs = [
      ['Danh Sách Tài Khoản', admin_users_path],
      [@user.name, edit_admin_user_path(@user.id)]
    ]
  end

  def update_user_contact
    @user = User.find(params[:id])
    @user_contact = UserContact.where(user_id: params[:id]).first()
    if @user_contact.update(edit_user_contact_params)
      redirect_to  edit_admin_user_path(params[:id])
    else
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

      @religions = [['Không', 0], ['Công Giáo', 1],['Phật Giáo', 2], ['Hòa Hảo', 3],['Tin Lành', 4], ['Hồi Giáo', 5], ['Khác', 6]]

      @title_page = @user.name
      @breadcrumbs = [
        ['Danh Sách Tài Khoản', admin_users_path],
        [@user.name, edit_admin_user_path(@user.id)]
      ]
      render :edit, status: :unprocessable_entity
    end
  end

  def update_relationship
    @user = User.find(params[:id])
    @relatioship = Relationship.where(user_id: params[:id]).first()
    if @relatioship.update(edit_relationship_params)
      redirect_to  edit_admin_user_path(params[:id])
    else
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

      @religions = [['Không', 0], ['Công Giáo', 1],['Phật Giáo', 2], ['Hòa Hảo', 3],['Tin Lành', 4], ['Hồi Giáo', 5], ['Khác', 6]]

      @title_page = @user.name
      @breadcrumbs = [
        ['Danh Sách Tài Khoản', admin_users_path],
        [@user.name, edit_admin_user_path(@user.id)]
      ]
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(edit_user_params)
      redirect_to  edit_admin_user_path(params[:id])
    else
      @provinces = Province.all
      @ethnicities = Ethnicity.all
      @religions = [['Không', 0], ['Công Giáo', 1],['Phật Giáo', 2], ['Hòa Hảo', 3],['Tin Lành', 4], ['Hồi Giáo', 5], ['Khác', 6]]

      render :edit, status: :unprocessable_entity
    end
  end

  def delete_student
    begin 
      rs = {succeed: false, data: {}}
      search = AppUtils.escape_search_query(params[:search])
      search = AppUtils.quote_string(search)
      user_ids = params[:user_ids].split(',')
      user_ids = user_ids.reject(&:blank?) if user_ids.present? && user_ids.kind_of?(Array)
      users = User.left_joins(:student_class).where.not(:role => 4)
      users = users.where("student_code ILIKE '%#{search}%' OR student_classes.class_name ILIKE '%#{search}%' OR full_name ILIKE '%#{search}%' OR email ILIKE '%#{search}%'") if search.present?
      users = users.where(:id => user_ids) if user_ids.present?
      delete_user_ids = users.pluck('users.id')

      ActiveRecord::Base.transaction do
        StudentClass.where(:user_id =>  delete_user_ids).delete_all
        UserContact.where(:user_id =>  delete_user_ids).delete_all
        Relationship.where(:user_id =>  delete_user_ids).delete_all
        User.where(:id => delete_user_ids).delete_all
      end

      rs[:succeed] = true
      return render json: rs
    rescue Exception => ex
      Rails.logger.info(ex.message)
      return render json: {
        :succeed => false,
        :data => nil,
        :message => ex.message
      }
    end
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

  def execute_users
    rs = {succeed: false, data: {}}
    page = params[:page]
    page_size = params[:page_size]
    search = AppUtils.escape_search_query(params[:search])
    search = AppUtils.quote_string(search)

    if page.blank? || page_size.blank?
			rs[:message] = 'Missing page or page size'
			return render json: rs
		end

    users = User.left_joins(:student_class).order(:id)
    users = users.where("student_code ILIKE '%#{search}%' OR student_classes.class_name ILIKE '%#{search}%' OR full_name ILIKE '%#{search}%' OR email ILIKE '%#{search}%'") if search.present?
    users = users.paginate(page: page, per_page: page_size)
    data = []
    users.each do |u|
      data << {
        :student_code => u.student_code,
        :last_class_name => u.last_class_name,
        :full_name => u.full_name,
        :name => u.name,
        :email => u.email,
        :id => u.id
      }
    end
    rs[:succeed] = true
    rs[:data] = data
    rs[:total] = users.total_entries

    return render json: rs
  end

  def download_csv
    search = AppUtils.escape_search_query(params[:search])
    search = AppUtils.quote_string(search)
    param_user_ids = params[:user_ids].split(',')
    param_user_ids = param_user_ids.reject(&:blank?) if param_user_ids.present? && param_user_ids.kind_of?(Array)
    users = User.left_joins(:student_class)
    users = users.where("student_code ILIKE '%#{search}%' OR student_classes.class_name ILIKE '%#{search}%' OR full_name ILIKE '%#{search}%' OR email ILIKE '%#{search}%'") if search.present?
    users = users.where(:id => param_user_ids) if param_user_ids.present?
    user_ids = users.group('users.id').pluck('users.id')
    file_name = 'Danh sach nguoi dung.xls'

    header = ['Mã học sinh', 'Lớp', 'Khối', 'Mã số lớp', 'Năm', 'Họ và tên', 'Tên', 'Email', 'Giới tính']
    header += ['Ngày tháng năm sinh', 'Dân tộc', 'Số CMND/CCCD', 'Hộ khẩu thường trú', 'Địa chỉ liên hệ', 'Số điện thoại liên lạc']
    header += ['Họ tên cha', 'Năm sinh của cha', 'Nghề nghiệp của cha', 'Địa chỉ liên hệ của cha', 'Số điện thoại của cha']
    header += ['Họ tên mẹ', 'Năm sinh của mẹ', 'Nghề nghiệp của mẹ', 'Địa chỉ liên hệ của mẹ', 'Số điện thoại của mẹ']
    header += ['Họ tên người giám hộ', 'Năm sinh của người giám hộ', 'Nghề nghiệp của người giám hộ', 'Địa chỉ liên hệ của người giám hộ', 'Số điện thoại của người giám hộ']

    header += ['Địa chỉ Hộ khẩu', 'Phường Hộ khẩu', 'Quận Hộ khẩu', 'Tỉnh Hộ khẩu']
    header += ['Địa chỉ Liên hệ', 'Phường Liên hệ', 'Quận Liên hệ', 'Tỉnh Liên hệ']
    # header += ['Họ tên người giám hộ', 'Năm sinh của người giám hộ', 'Nghề nghiệp của người giám hộ', 'Địa chỉ liên hệ của người giám hộ', 'Số điện thoại của người giám hộ']
    data_users = User.eager_load(:user_contact, :relationship).where(id: user_ids)
    ethnicities = Ethnicity.all

    excel_book = Spreadsheet::Workbook.new
    sheet_page = excel_book.create_worksheet :name => 'Danh sach nguoi dung'
    # Header row
    sheet_page.insert_row(0, header)
    ExcelUtils.format_rows_header(sheet_page, [0])
    row_index = 1
    data_users.each do |u|
      user_contact = u.user_contact
      relationship = u.relationship
      student_class = u.last_class
      gender_name = ethnicity = student_class_code = grade = year = class_name = ''

      if student_class.present?
        student_class_code = student_class.student_class_code
        grade = student_class.grade
        year = student_class.year
        class_name = student_class.class_name
      end

      # gender
      gender_name = u.gender == 1 ? 'Nam' : 'Nữ' if u.gender.present?
      # ethnicity
      t_ethnicity = ethnicities.select{|e| e.code == u.ethnicity}.first if u.ethnicity.present?
      ethnicity = u.ethnicity == 0 ? u.another_ethnicity : t_ethnicity.name if u.ethnicity.present?
      # identification
      identification = u.identification.present? ? u.identification : 'Chưa có'

      row_data = [u.student_code, class_name.present? ? class_name : 'Chưa có', grade, student_class_code, year, u.full_name, u.name, u.email, gender_name]
      row_data += [u.birthday, ethnicity, identification, user_contact.household_full_address, user_contact.contact_full_address, user_contact.phone_number]
      row_data += [relationship.father_name, relationship.father_year, relationship.father_career, relationship.father_address, relationship.father_phone]
      row_data += [relationship.mother_name, relationship.mother_year, relationship.mother_career, relationship.mother_address, relationship.mother_phone]
      row_data += [relationship.guardian_name, relationship.guardian_year, relationship.guardian_career, relationship.guardian_address, relationship.guardian_phone]

      row_data += [user_contact.household_address_array[0], user_contact.household_address_array[1], user_contact.household_address_array[2], user_contact.household_address_array[3]]
      row_data += [user_contact.contact_full_array[0], user_contact.contact_full_array[1], user_contact.contact_full_array[2], user_contact.contact_full_array[3]]
      sheet_page.insert_row(row_index, row_data)
      row_index += 1
    end
    excel_data = StringIO.new
		excel_book.write excel_data

    send_data excel_data.string, :filename => file_name, :disposition => 'inline'
  end


  def edit_secondary_school_user
    @user = User.find(params[:id])
    @secondarySchoolUser = SecondarySchoolUser.where(user_id: params[:id]).first()
    if @secondarySchoolUser.nil?
      @secondarySchoolUser = SecondarySchoolUser.create([user_id: params[:id]]).first()
    end

    @title_page = 'Cập nhật kết quả học tập lớp 9'
    @breadcrumbs = [
      ['Thông tin cá nhân', basic_informations_path],
      ['Cập nhật kết quả học tập lớp 9', edit_secondary_school_user_path]
    ]
  end

  def update_secondary_school_user
    @user = User.find(params[:id])
    @secondary_school_user = SecondarySchoolUser.where(user_id: params[:id]).first()
    secondary_school_user = secondary_school_user_params
    secondary_school_user[:other_language] = 'Tiếng Anh'

    if @secondary_school_user.blank?
      SecondarySchoolUser.create!(secondary_school_user)
      flash[:success] = 'Cập nhập thành công!'
    else
      if @secondary_school_user.editable
        @secondary_school_user.update!(secondary_school_user)
        flash[:success] = 'Cập nhập thành công!'
      else
        flash[:error] = 'Hết hạn cập nhật!'
      end
    end

    redirect_to  admin_user_path(params[:id])
  end


  private


  def edit_user_params
    params.require(:user).permit( :full_name, :name, :birthday, :gender, :province, :ethnicity, :another_ethnicity,
                                  :identifier_code, :identification, :identification_type, :identification_chip,
                                  :identification, :role, :religion, :another_religion, :health_insurance_code, :nationality)
  end

  def edit_user_contact_params
    params.require(:user_contact).permit( :household_province, :household_district, :household_ward, :household_address,
                                          :contact_province, :contact_district, :contact_ward, :contact_address, :phone_number)
  end

  def edit_relationship_params
    params.require(:relationship).permit( :difficult_area, :difficult_code, :revolutionary_family,
                                          :father_name, :father_year, :father_career, :father_phone, :father_address,
                                          :mother_name, :mother_year, :mother_career, :mother_phone, :mother_address,
                                          :guardian_name, :guardian_year, :guardian_career, :guardian_phone, :guardian_address, :vietschool_connect_phone)
  end

  def secondary_school_user_params
    params.require(:secondary_school_user).permit(:school_name, :school_type, :other_language, :math, :physics,
                                                  :chemistry, :biological, :literature, :history, :geography, :english,
                                                  :civic_education, :technology, :admission_test_score, :exercise_result,
                                                  :ranked_academic, :conduct, :subject_average, :subject_average_semester_one, :subject_average_semester_two,
                                                  :math_semester_one, :math_semester_two, :physics_semester_one, :physics_semester_two, :chemistry_semester_one,
                                                  :chemistry_semester_two, :biological_semester_one, :biological_semester_two, :literature_semester_one,
                                                  :literature_semester_two, :history_semester_one, :history_semester_two, :geography_semester_one,
                                                  :geography_semester_two, :english_semester_one, :english_semester_two, :civic_education_semester_one,
                                                  :civic_education_semester_two, :technology_semester_one, :technology_semester_two
    )
  end
end
