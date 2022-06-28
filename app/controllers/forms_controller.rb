class FormsController < ApplicationController
  include ApplicationHelper
  # include PdfToPdfService
  before_action :is_signed_in?

  def index
  end

  def profile_file
    # user_contact = UserContact.find(user_id: current_user.id)

    left = 28;
    bottom = 33;
    size = 4;

    # chữ A thêm 3 số cuối của email
    # Vd email là 220789.ahdhfjc@….
    # Thì mã là A789
    string_code = current_user.student_code.strip
    string_length = string_code.length
    code = string_length > 3 ? (string_code[string_length - 3, string_length - 1]): ''
    code = 'A' + code



    data =
      [
        # [:font, Rails.root.join("app", "assets", "fonts", "TimesNewRoman.ttf")], # set font cho toàn bộ content file
        [:font, "LoraWeight"], # set font cho toàn bộ content file
        [:draw_text, code, at: [left + 492, bottom + 742], size: size + 7, color: "#FF0000", styles: [:bold, :italic] ], # điền text "2018" với font size 10 vào vị trí (260, 790)
        [:draw_text, current_user.full_name, at: [left + 188, bottom + 695], size: size + 7],
        [:draw_text, current_user.gender == 0 ? "Nữ" : "Nam", at: [left + 460, bottom + 696], size: size + 5],
    ]

    #     # birthday
    # render json: current_user.birthday
    # yyyyMMdd
    array_birthday = current_user.birthday.to_s.delete('-').chars
    data.concat [
        [:draw_text, array_birthday[6], at: [left + 258, bottom + 677], size: size + 5],
        [:draw_text, array_birthday[7], at: [left + 280, bottom + 677], size: size + 5],

        [:draw_text, array_birthday[4], at: [left + 326, bottom + 677], size: size + 5],
        [:draw_text, array_birthday[5], at: [left + 348, bottom + 677], size: size + 5],

        [:draw_text, array_birthday[0], at: [left + 389, bottom + 678], size: size + 5],
        [:draw_text, array_birthday[1], at: [left + 410, bottom + 678], size: size + 5],
        [:draw_text, array_birthday[2], at: [left + 432, bottom + 678], size: size + 5],
        [:draw_text, array_birthday[3], at: [left + 454, bottom + 678], size: size + 5],

        # Nơi sinh, Dân tộc, *Quốc tịch, Tôn giáo
        [:draw_text, current_user.province_name, at: [left + 74, bottom + 650], size: size + 6],
        [:draw_text, current_user.ethnicity_name, at: [left + 72, bottom + 635], size: size + 6],
        [:draw_text, "Việt Nam", at: [left + 245, bottom + 635], size: size + 6],
        [:draw_text, current_user.religion_name, at: [left + 460, bottom + 635], size: size + 6],
      ]

    identification_code = current_user.identification_type == 3 || current_user.identification_type == 4 ? current_user.identification : current_user.identification_chip ? current_user.identifier_code : '';
    # render json: identification_code
    if (identification_code.length == 12)
      identification_array = identification_code.chars
      # mã định danh, cccd
      data.concat [
        [:draw_text, identification_array[0], at: [left + 265, bottom + 620], size: size + 6],
        [:draw_text, identification_array[1], at: [left + 285, bottom + 620], size: size + 6],
        [:draw_text, identification_array[2], at: [left + 302, bottom + 620], size: size + 6],
        [:draw_text, identification_array[3], at: [left + 320, bottom + 620], size: size + 6],
        [:draw_text, identification_array[4], at: [left + 340, bottom + 620], size: size + 6],
        [:draw_text, identification_array[5], at: [left + 357, bottom + 620], size: size + 6],
        [:draw_text, identification_array[6], at: [left + 376, bottom + 620], size: size + 6],
        [:draw_text, identification_array[7], at: [left + 395, bottom + 620], size: size + 6],
        [:draw_text, identification_array[8], at: [left + 414, bottom + 620], size: size + 6],
        [:draw_text, identification_array[9], at: [left + 433, bottom + 620], size: size + 6],
        [:draw_text, identification_array[10], at: [left + 452, bottom + 620], size: size + 6],
        [:draw_text, identification_array[11], at: [left + 470, bottom + 620], size: size + 6],
      ]
    end

    # mã định danh, cccd
    #     [:draw_text, "0", at: [left + 265, bottom + 620], size: size + 6],
    #     [:draw_text, "7", at: [left + 285, bottom + 620], size: size + 6],
    #     [:draw_text, "8", at: [left + 302, bottom + 620], size: size + 6],
    #     [:draw_text, "9", at: [left + 320, bottom + 620], size: size + 6],
    #     [:draw_text, "3", at: [left + 340, bottom + 620], size: size + 6],
    #     [:draw_text, "4", at: [left + 357, bottom + 620], size: size + 6],
    #     [:draw_text, "8", at: [left + 376, bottom + 620], size: size + 6],
    #     [:draw_text, "1", at: [left + 395, bottom + 620], size: size + 6],
    #     [:draw_text, "3", at: [left + 414, bottom + 620], size: size + 6],
    #     [:draw_text, "4", at: [left + 433, bottom + 620], size: size + 6],
    #     [:draw_text, "9", at: [left + 452, bottom + 620], size: size + 6],
    #     [:draw_text, "7", at: [left + 470, bottom + 620], size: size + 6],
    #

    data.concat [
        [:draw_text, current_user.identification_type_name_export, at: [left + 140, bottom + 605], size: size + 6],
        [:draw_text, current_user.identification.length == 9 ? current_user.identification.length : '', at: [left + 160, bottom + 592], size: size + 6]
    ]
    #
    #     Số sổ bảo hiểm y tế
    health_insurance_code = current_user.health_insurance_code
    if health_insurance_code.length == 15
      data.concat [
        [:draw_text, health_insurance_code[0,2], at: [left + 261, bottom + 576], size: size + 6],
        [:draw_text, health_insurance_code[2,1], at: [left + 285, bottom + 576], size: size + 6],
        [:draw_text, health_insurance_code[3,3], at: [left + 305, bottom + 576], size: size + 6],
        [:draw_text, health_insurance_code[5,3] + " " + health_insurance_code[8,3] + " " + health_insurance_code[11,4], at: [left + 330, bottom + 576], size: size + 6],
      ]
    end

    #
    #
    #     [:draw_text, "8", at: [left + 376, bottom + 561], size: size + 6],
    #     [:draw_text, "1", at: [left + 396, bottom + 561], size: size + 6],
    #
    #     [:draw_text, "8", at: [left + 440, bottom + 561], size: size + 6],
    #     [:draw_text, "1", at: [left + 461, bottom + 561], size: size + 6],
    #
    #     [:draw_text, "123 Đường XYZ, Phường 7, Quận Tân Bình, TP. Hồ Chí Minh", at: [left + 28, bottom + 547], size: size + 6],
    #
    #     [:draw_text, "123 Đường XYZ, Phường 7, Quận Tân Bình, TP. Hồ Chí Minh", at: [left + 100, bottom + 520], size: size + 6],
    #     [:draw_text, "0987654321", at: [left + 130, bottom + 505], size: size + 6],
    #     [:draw_text, "123456.thuyan@thptbinhhunghoa.edu.vn", at: [left + 65, bottom + 490], size: size + 6],
    #
    #     [:draw_text, "Không", at: [left + 105, bottom + 444], size: size + 6],
    #     [:draw_text, "Không", at: [left + 370, bottom + 444], size: size + 6],
    #     [:draw_text, "Không", at: [left + 95, bottom + 429], size: size + 6],
    #
    #
    #     [:draw_text, "Bùi Văn A", at: [left + 108, bottom + 385], size: size + 6],
    #     [:draw_text, "1960", at: [left + 80, bottom + 370], size: size + 6],
    #     [:draw_text, "Tự Do", at: [left + 335, bottom + 370], size: size + 6],
    #
    #     [:draw_text, "123 Đường XYZ, Phường 7, Quận Tân Bình, TP. Hồ Chí Minh", at: [left + 100, bottom + 355], size: size + 6],
    #     [:draw_text, "0983271234", at: [left + 98, bottom + 340], size: size + 6],
    #
    #     [:draw_text, "Bùi Văn A", at: [left + 104, bottom + 297], size: size + 6],
    #     [:draw_text, "1960", at: [left + 80, bottom + 282], size: size + 6],
    #     [:draw_text, "Tự Do", at: [left + 335, bottom + 282], size: size + 6],
    #
    #     [:draw_text, "123 Đường XYZ, Phường 7, Quận Tân Bình, TP. Hồ Chí Minh", at: [left + 100, bottom + 267], size: size + 6],
    #     [:draw_text, "0983271234", at: [left + 98, bottom + 252], size: size + 6],
    #
    #
    #     [:draw_text, "Bùi Văn A", at: [left + 175, bottom + 209], size: size + 6],
    #     [:draw_text, "1960", at: [left + 80, bottom + 194], size: size + 6],
    #     [:draw_text, "Tự Do", at: [left + 335, bottom + 194], size: size + 6],
    #
    #     [:draw_text, "123 Đường XYZ, Phường 7, Quận Tân Bình, TP. Hồ Chí Minh", at: [left + 100, bottom + 179], size: size + 6],
    #     [:draw_text, "0983271234", at: [left + 98, bottom + 164], size: size + 6],
    #
    #     [:draw_text, "0983271234", at: [left + 299, bottom + 137], size: size + 6],
    #
    #     [:draw_text, "06", at: [left + 354, bottom + 71], size: size + 3],
    #     [:draw_text, "05", at: [left + 390, bottom + 71], size: size + 3],
    #     [:draw_text, "2022", at: [left + 420, bottom + 71], size: size + 3],
    #
    #     # [:draw_text, "BÙI THỊ THÚY AN".valid_encoding?, at: [200, 730], size: 12, font: 'TimesNewRoman'],
    #     # [:text_box, "20", at: [333, 790], size: 10],
    #     # [:text_box, "NGUYEN DUC TUNG", at: [135, 748], size: 20],
    #     # [:text_box, "1991", at: [120, 701], size: 10],
    #     # [:text_box, "2", at: [170, 701], size: 10],
    #     # [:text_box, "31", at: [210, 701], size: 10],
    #     # [:text_box, "26", at: [285, 701], size: 10],
    #     # [:stroke_ellipse, [348, 688], 10], # vẽ đường tròn với bán kính 10px ở vị trí (348, 688)
    #   ]
    # ]

    # data = [
    #   [
    #     [:font, "LoraWeight"], # set font cho toàn bộ content file
    #     # [:draw_text, "A456", at: [left + 492, bottom + 742], size: size + 7, color: "#FF0000", styles: [:bold, :italic] ], # điền text "2018" với font size 10 vào vị trí (260, 790)
    #     [:draw_text, current_user.full_name, at: [left + 170, bottom + 696], size: size + 6],
    #     [:draw_text, current_user.gender == 0 ? "Nữ" : "Nam", at: [left + 460, bottom + 696], size: size + 5],
    #   ]
    # ]

    file_name = "tmp/ly_lich_hs_" + rand.to_s[2..11]  + ".pdf"
    # file_name = "out2.pdf"
    PdfToPdfService.new("ly_lich_hs_new_no_data_pdf.pdf", file_name, [data]).perform
    File.open(file_name, 'r') do |f|
      send_data f.read, type: "application/pdf"
    end
    File.delete(file_name)
  end

  def score_board_file
    left = 30;
    bottom = 30;
    size = 5;
    data = [
      [
        # [:font, Rails.root.join("app", "assets", "fonts", "TimesNewRoman.ttf")], # set font cho toàn bộ content file
        [:font, "LoraWeight"], # set font cho toàn bộ content file
      ]
    ]


    file_name = "tmp/DonNhapHoc_no_data" + rand.to_s[2..11]  + ".pdf"

    # file_name = "out2.pdf"
    PdfToPdfService.new("DonNhapHoc_no_data_pdf.pdf", file_name, data).perform
    File.open(file_name, 'r') do |f|
      send_data f.read, type: "application/pdf"
    end
    File.delete(file_name)

  end

  def commitment_file
    left = 30;
    bottom = 30;
    size = 5;
    data = [
      [
        # [:font, Rails.root.join("app", "assets", "fonts", "TimesNewRoman.ttf")], # set font cho toàn bộ content file
        [:font, "LoraWeight"], # set font cho toàn bộ content file
      ]
    ]


    file_name = "tmp/DonCamKet_no_data_pdf_" + rand.to_s[2..11]  + ".pdf"

    # file_name = "out2.pdf"
    PdfToPdfService.new("DonCamKet_no_data_pdf.pdf", file_name, data).perform
    File.open(file_name, 'r') do |f|
      send_data f.read, type: "application/pdf"
    end
    File.delete(file_name)

  end
end
