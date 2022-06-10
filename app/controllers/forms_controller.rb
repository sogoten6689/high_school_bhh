class FormsController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?


  def index
  end

  def profile_file
    # require 'hexapdf'
    # # require 'stringio'
    # require 'tempfile'
    #
    # doc = HexaPDF::Document.open('profile_template.pdf')
    # # doc.write('modified.pdf')
    # # doc = HexaPDF::Document.new
    # canvas = doc.pages.add.canvas
    # canvas.font('Helvetica', size: 100)
    # canvas.text("Hello World2!", at: [20, 400])
    #
    # io = Tempfile.new(['so_yeu_ly_lich', '.pdf'], 'tmp' )
    # doc.write(io)
    # # Do something with io
    # # return io
    # send_file io.path
    #

    data = [
      [
        # [:font, Rails.root.join("app", "assets", "fonts", "Helvetica.ttf")], # set font cho toàn bộ content file
        # [:text_box, "2018", at: [260, 790], size: 10], # điền text "2018" với font size 10 vào vị trí (260, 790)
        # [:text_box, "6", at: [307, 790], size: 10],
        # [:text_box, "20", at: [333, 790], size: 10],
        # [:text_box, "グエン　ドゥック　トゥン", at: [135, 774], size: 10],
        # [:text_box, "NGUYEN DUC TUNG", at: [135, 748], size: 20],
        # [:text_box, "1991", at: [120, 701], size: 10],
        # [:text_box, "2", at: [170, 701], size: 10],
        # [:text_box, "31", at: [210, 701], size: 10],
        # [:text_box, "26", at: [285, 701], size: 10],
        # [:stroke_ellipse, [348, 688], 10], # vẽ đường tròn với bán kính 10px ở vị trí (348, 688)
        # [:text_box, "トウキョウト シンジュクク シンジュク ゴチョウメ ニノイチ", at: [135, 673], size: 10],
        # [:text_box, "160-0022", at: [135, 658], size: 10],
        # [:text_box, "東京都新宿区新宿５丁目２ー1", at: [135, 635], size: 18],
        # [:text_box, "0987654321", at: [425, 653], size: 12]
      ],
      [
        # page 2 tạm thời không có nội dung nên truyền vào mảng rỗng
      ],
      [
        # page 3 tạm thời không có nội dung nên truyền vào mảng rỗng
      ],
      [
        # page 3 tạm thời không có nội dung nên truyền vào mảng rỗng
      ],
      [
        # page 3 tạm thời không có nội dung nên truyền vào mảng rỗng
      ]
    ]

    # PdfToPdfService.new("profile_template.pdf", "out.pdf", data).perform

  end
end
