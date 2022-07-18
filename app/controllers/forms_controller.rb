class FormsController < ApplicationController
  include ApplicationHelper
  # include PdfToPdfService
  before_action :is_signed_in?

  def index
  end

  def profile_file

    if current_user.role != 5 && params[:id].to_s != current_user.id.to_s
      return redirect_to home_path
    end

    require 'omnidocx'
    require "i18n"

    user = User.find(params[:id])

    if user.nil?
      return redirect_to home_path
    end

    user_contact = UserContact.where(:user_id => user.id).first()
    relationship = Relationship.where(:user_id =>  user.id).first()
    if user_contact.nil?
      user_contact = UserContact.create([user_id: current_user.id])
    end

    if relationship.nil?
      relationship = Relationship.create([user_id: current_user.id])
    end

    string_code = user.student_code.nil? ? '' : user.student_code.strip
    string_length = string_code.length
    code = string_length > 3 ? (string_code[string_length - 3, string_length - 1]): ''
    code = 'A' + code

    # birthday
    array_birthday = user.birthday.nil? ? "        " : user.birthday.to_s.delete('-').chars

    json_data = {
      "full_name" => user.full_name.upcase,
      "ucod" => code,
      "gender" => user.gender == 0 ? "Nữ" : "Nam",

      "b3" => "1",
      "b4" => "1",
      "codedifficult_test" => relationship.difficult_area != 0 && !relationship.difficult_code.nil? ? relationship.difficult_code : 'Không',
      "contact_phone" => user_contact.phone_number.nil? ? '' : user_contact.phone_number,

      "P1" => array_birthday[6],
      "P2" => array_birthday[7],
      "m1" => array_birthday[4],
      "m2" => array_birthday[5],
      "y1" => array_birthday[0],
      "y2" => array_birthday[1],
      "y3" => array_birthday[2],
      "y4" => array_birthday[3],

      "province" => user.province_name,
      "ethnicity_name" => user.ethnicity_name,
      "nationality" => user.nationality.nil? ? '' : user.nationality.upcase,
      "religion_name" => user.religion_name,
    }

    identification_code = user.identification_type == 3 || user.identification_type == 4 ? user.identification : user.identification_chip ? user.identifier_code : ''
    identification_array = identification_code.nil? ? "            " : identification_code.chars

    # render json: identification_array
    json_data['id1'] = identification_array[0].to_s
    json_data['id2'] = identification_array[1].to_s
    json_data['id3'] = identification_array[2].to_s
    json_data['id4'] = identification_array[3].to_s
    json_data['id5'] = identification_array[4].to_s
    json_data['id6'] = identification_array[5].to_s
    json_data['id7'] = identification_array[6].to_s
    json_data['id8'] = identification_array[7].to_s
    json_data['id9'] = identification_array[8].to_s
    json_data['i10'] = identification_array[9].to_s
    json_data['i11'] = identification_array[10].to_s
    json_data['i12'] = identification_array[11].to_s

    json_data['identification_type'] = user.identification_type_name_export
    json_data['identification'] = !user.identification.nil? && user.identification.length == 9 ? user.identification : ''

    # bao hiem y te
    health_insurance_code = user.health_insurance_code.nil? ? "               " : user.health_insurance_code

    json_data['hs'] = health_insurance_code[0,2].nil? ? '' : health_insurance_code[0,2]
    json_data['bh1'] = health_insurance_code[2,1].nil? ? '' : health_insurance_code[2,1]
    json_data['bh2'] = health_insurance_code[3,2].nil? ? '' : health_insurance_code[3,2]

    bh_3_string = health_insurance_code[5,3].nil? ? '' : health_insurance_code[5,3]
    bh_3_string += health_insurance_code[8,3].nil? ? '' : " " + health_insurance_code[8,3]
    bh_3_string += health_insurance_code[11,3].nil? ? '' : " " + health_insurance_code[11,4]
    json_data['bh3'] = bh_3_string

    json_data['household_full_address'] = user_contact.household_full_address
    json_data['contact_full_address'] = user_contact.contact_full_address

    json_data['email_contact'] = user.email

    json_data['difficult_area'] = relationship.difficult_area_name_export
    json_data['sosongheo'] = relationship.difficult_area != 0 && !relationship.difficult_code.nil? ? relationship.difficult_code : 'Không'
    json_data['revolutionary_family'] = relationship.revolutionary_family == 1 ? "Có" : "Không"

    json_data['father_name'] = relationship.father_name.nil? ? '' : relationship.father_name.upcase
    json_data['nam_sinh_ba'] = relationship.father_year.nil? ? '' : relationship.father_year.to_s
    json_data['father_career'] = relationship.father_career.nil? ? '' : relationship.father_career
    json_data['father_phone'] = relationship.father_phone.nil? ? '' : relationship.father_phone
    json_data['father_address'] = relationship.father_address.nil? ? '' : relationship.father_address

    json_data['guardian_name'] = relationship.guardian_name.nil? ? '' : relationship.guardian_name.upcase
    json_data['guardian_year'] = relationship.guardian_year.nil? ? '' : relationship.guardian_year.to_s
    json_data['guardian_career'] = relationship.guardian_career.nil? ? '' : relationship.guardian_career.to_s
    json_data['guardian_phone'] = relationship.guardian_phone.nil? ? '' : relationship.guardian_phone.to_s
    json_data['guardian_address'] = relationship.guardian_address.nil? ? '' : relationship.guardian_address.to_s

    json_data['mother_name'] = relationship.mother_name.nil? ? '' : relationship.mother_name.upcase
    json_data['mother_year'] = relationship.mother_year.nil? ? '' : relationship.mother_year.to_s
    # json_data['mother_career'] = relationship.mother_career.nil? ? '' : relationship.mother_career
    json_data['mother_career'] = ''

    json_data['mother_phone'] = relationship.mother_phone.nil? ? '' : relationship.mother_phone.to_s
    json_data['mother_address'] = relationship.mother_address.nil? ? '' : relationship.mother_address.to_s

    json_data['testvietschool'] = relationship.vietschool_connect_phone.nil? ? '' : relationship.vietschool_connect_phone.to_s

    date = Time.now
    json_data['now_date'] = date.strftime("%d")
    json_data['now_month'] = date.strftime("%m")
    json_data['now_year'] = date.strftime("%Y")

    file_name = "tmp/ly_lich_hs_" + rand.to_s[2..11]  + ".docx"

    Omnidocx::Docx.replace_doc_content(replacement_hash=json_data, 'ly_lich_hs_code.docx', file_name)

    # out_file = I18n.transliterate(user.name) + "_" +  user.student_code + "_syll.docx"
    out_file = user.student_code + "_syll.docx"

    File.open(file_name, 'r') do |f|
      send_data f.read, :filename => out_file, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    end
    File.delete(file_name)
  end

  def score_board_file

    if current_user.role != 5 && params[:id].to_s != current_user.id.to_s
      return redirect_to home_path
    end

    require 'omnidocx'
    require "i18n"

    user = User.find (params[:id])

    if user.nil?
      return redirect_to home_path
    end

    user_contact = UserContact.where(:user_id => user.id).first()
    relationship = Relationship.where(:user_id =>  user.id).first()
    secondary_school_user = SecondarySchoolUser.where(:user_id =>  user.id).first()

    if secondary_school_user.nil?
      secondary_school_user = SecondarySchoolUser.create([user_id: user.id])
    end

    if user_contact.nil?
      user_contact = UserContact.create([user_id: user.id])
    end

    if relationship.nil?
      relationship = Relationship.create([user_id: user.id])
    end

    elective_subject = ElectiveSubject.where(:user_id =>  user.id).first()

    json_data = {
      "full_name" => user.full_name.upcase,
      "gender" => user.gender == 0 ? "Nữ" : "Nam",

      "birthday" => user.birthday.nil? ? '' :  user.birthday.strftime("%d-%m-%Y"),
      "province" => user.province_name,
      "contact_full_address" => user_contact.contact_full_address,
      "phone_contact" => relationship.vietschool_connect_phone.nil? ? "Chưa nhập" : relationship.vietschool_connect_phone,
      "school_type" => secondary_school_user.school_type.nil? ? "Chưa nhập" : secondary_school_user.school_type,
      "school_name" => secondary_school_user.school_name.nil? ? "Chưa nhập" : secondary_school_user.school_name,
      "other_language" => secondary_school_user.other_language.nil? ? "Chưa nhập" : secondary_school_user.other_language,
      "admission_test_score" => secondary_school_user.admission_test_score.nil? ? 'Chưa nhập' : secondary_school_user.admission_test_score.to_s,
      "conduct" => secondary_school_user.conduct.nil? ? 'Chưa nhập' : secondary_school_user.conduct,
      "ranked" => secondary_school_user.ranked_academic.nil? ? 'Chưa nhập' : secondary_school_user.ranked_academic,

      "Toan0" => secondary_school_user.math.nil? ? '0' : secondary_school_user.math.to_s,
      "Math1" => secondary_school_user.math_semester_one.nil? ? '0' : secondary_school_user.math_semester_one.to_s,
      "Math2" => secondary_school_user.math_semester_two.nil? ? '0' : secondary_school_user.math_semester_two.to_s,

      "Ly0" => secondary_school_user.physics.nil? ? '0' : secondary_school_user.physics.to_s,
      "Ly1" => secondary_school_user.physics_semester_one.nil? ? '0' : secondary_school_user.physics_semester_one.to_s,
      "Physics2" => secondary_school_user.physics_semester_two.nil? ? '0' : secondary_school_user.physics_semester_two.to_s,

      "Hoa0" => secondary_school_user.chemistry.nil? ? '0' : secondary_school_user.chemistry.to_s,
      "Hoa1" => secondary_school_user.chemistry_semester_one.nil? ? '0' : secondary_school_user.chemistry_semester_one.to_s,
      "Hoa2" => secondary_school_user.chemistry_semester_two.nil? ? '0' : secondary_school_user.chemistry_semester_two.to_s,

      "Sinh0" => secondary_school_user.biological.nil? ? '0' : secondary_school_user.biological.to_s,
      "Sinh1" => secondary_school_user.biological_semester_one.nil? ? '0' : secondary_school_user.biological_semester_one.to_s,
      "Sinh2" => secondary_school_user.biological_semester_two.nil? ? '0' : secondary_school_user.biological_semester_two.to_s,

      "Van0" => secondary_school_user.literature.nil? ? '0' : secondary_school_user.literature.to_s,
      "Van1" => secondary_school_user.literature_semester_one.nil? ? '0' : secondary_school_user.literature_semester_one.to_s,
      "Van2" => secondary_school_user.literature_semester_two.nil? ? '0' : secondary_school_user.literature_semester_two.to_s,

      "Su0" => secondary_school_user.history.nil? ? '0' : secondary_school_user.history.to_s,
      "Su1" => secondary_school_user.history_semester_one.nil? ? '0' : secondary_school_user.history_semester_one.to_s,
      "Su2" => secondary_school_user.history_semester_two.nil? ? '0' : secondary_school_user.history_semester_two.to_s,


      "Dia0" => secondary_school_user.geography.nil? ? '0' : secondary_school_user.geography.to_s,
      "Dia1" => secondary_school_user.geography_semester_one.nil? ? '0' : secondary_school_user.geography_semester_one.to_s,
      "Dia2" => secondary_school_user.geography_semester_two.nil? ? '0' : secondary_school_user.geography_semester_two.to_s,

      "Anh0" => secondary_school_user.english.nil? ? '0' : secondary_school_user.english.to_s,
      "Anh1" => secondary_school_user.english_semester_one.nil? ? '0' : secondary_school_user.english_semester_one.to_s,
      "Anh2" => secondary_school_user.english_semester_two.nil? ? '0' : secondary_school_user.english_semester_two.to_s,

      "CongDan0" => secondary_school_user.civic_education.nil? ? '0' : secondary_school_user.civic_education.to_s,
      "CongDan1" => secondary_school_user.civic_education_semester_one.nil? ? '0' : secondary_school_user.civic_education_semester_one.to_s,
      "CongDan2" => secondary_school_user.civic_education_semester_two.nil? ? '0' : secondary_school_user.civic_education_semester_two.to_s,

      "Nghe0" => secondary_school_user.technology.nil? ? '0' : secondary_school_user.technology.to_s,
      "Nghe1" => secondary_school_user.technology_semester_one.nil? ? '0' : secondary_school_user.technology_semester_one.to_s,
      "Nghe2" => secondary_school_user.technology_semester_two.nil? ? '0' : secondary_school_user.technology_semester_two.to_s,

      "TrungB0" => secondary_school_user.subject_average.nil? ? '0' : secondary_school_user.subject_average.to_s,
      "TrungB1" => secondary_school_user.subject_average_semester_one.nil? ? '0' : secondary_school_user.subject_average_semester_one.to_s,
      "TrungB2" => secondary_school_user.subject_average_semester_two.nil? ? '0' : secondary_school_user.subject_average_semester_two.to_s,

    }

    if !elective_subject.nil?
      thematic_group = THEMATIC_GROUP.select{|g| g[:code] == elective_subject.thematic_group}.first[:name]
      group_subject = GROUP_SUBJECT.select{|g| g[:code] == elective_subject.group_subject}.first[:name]
      elective_subject_one = ELECTIVE_SUBJECT_ONE.select{|g| g[:code] == elective_subject.elective_subject_one}.first[:name]
      elective_subject_two = ELECTIVE_SUBJECT_TWO.select{|g| g[:code] == elective_subject.elective_subject_two}.first[:name]

      json_data['MonHocTuChon'] = group_subject + " - " + elective_subject_one + " - " + elective_subject_two
      json_data['MonChuyenDe'] = thematic_group

    end


    date = Time.now
    json_data['now_date'] = date.strftime("%d")
    json_data['now_month'] = date.strftime("%m")
    json_data['now_year'] = date.strftime("%Y")

    json_data['next_year_top'] = (date.strftime("%Y").to_i + 1).to_s

    file_name = "tmp/DonXinNhaphoc" + rand.to_s[2..11]  + ".docx"

    Omnidocx::Docx.replace_doc_content(replacement_hash=json_data, 'DonXinNhaphoc.docx', file_name)

    # out_file = I18n.transliterate(user.name) + "_" +  user.student_code + "_donnhaphoc.docx"
    out_file = user.student_code + "_donnhaphoc.docx"

    File.open(file_name, 'r') do |f|
      send_data f.read, :filename => out_file, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    end
    File.delete(file_name)

  end

  def commitment_file

    if current_user.role != 5 && params[:id].to_s != current_user.id.to_s
        return redirect_to home_path
    end

    require 'omnidocx'
    require "i18n"

    user = User.find (params[:id])

    if user.nil?
      return redirect_to home_path
    end

    relationship = Relationship.where(:user_id => user.id ).first()
    if relationship.nil?
      relationship = Relationship.create([user_id: user.id])
    end

    json_data = {
      "full_name" => user.full_name.upcase,
    }

    json_data['father_name'] = relationship.father_name.nil? ? '' : relationship.father_name.upcase
    json_data['nam_sinh_ba'] = relationship.father_year.nil? ? '' : relationship.father_year.to_s
    json_data['father_career'] = relationship.father_career.nil? ? '' : relationship.father_career
    json_data['father_phone'] = relationship.father_phone.nil? ? '' : relationship.father_phone
    json_data['father_address'] = relationship.father_address.nil? ? '' : relationship.father_address
    # #
    json_data['guardian_name'] = relationship.guardian_name.nil? ? '' : relationship.guardian_name.upcase
    json_data['guardian_year'] = relationship.guardian_year.nil? ? '' : relationship.guardian_year.to_s
    json_data['guardian_career'] = relationship.guardian_career.nil? ? '' : relationship.guardian_career.to_s
    json_data['guardian_phone'] = relationship.guardian_phone.nil? ? '' : relationship.guardian_phone.to_s
    json_data['guardian_address'] = relationship.guardian_address.nil? ? '' : relationship.guardian_address.to_s

    json_data['mother_name'] = relationship.mother_name.nil? ? '' : relationship.mother_name.upcase
    json_data['mother_year'] = relationship.mother_year.nil? ? '' : relationship.mother_year.to_s
    # json_data['mother_career'] = relationship.mother_career.nil? ? '' : (relationship.mother_career.to_s + " ")
    json_data['mother_career'] = ''
    json_data['mother_phone'] = relationship.mother_phone.nil? ? '' : relationship.mother_phone.to_s
    json_data['mother_address'] = relationship.mother_address.nil? ? '' : relationship.mother_address.to_s

    json_data['testvietschool'] = relationship.vietschool_connect_phone.nil? ? '' : relationship.vietschool_connect_phone.to_s

    date = Time.now
    json_data['now_date'] = date.strftime("%d")
    json_data['now_month'] = date.strftime("%m")
    json_data['now_year'] = date.strftime("%Y")


    file_name = "tmp/DonCamKet" + rand.to_s[2..11]  + ".docx"

    Omnidocx::Docx.replace_doc_content(replacement_hash=json_data, 'DonCamKet.docx', file_name)

    out_file = user.student_code + "_camket.docx"
    File.open(file_name, 'r') do |f|
      send_data f.read,:filename => out_file, type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
    end
    File.delete(file_name)
  end
end
