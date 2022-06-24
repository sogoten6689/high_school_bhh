class PdfToPdfService
  PAGE_MARGIN = [0, 0, 0, 0].freeze

  attr_reader :template_file, :template_pdf, :content_pdf, :out_file, :data

  def initialize template_file, out_file, data
    @template_file = template_file
    @template_pdf = CombinePDF.load template_file
    @content_pdf = Prawn::Document.new skip_page_creation: true
    # @content_pdf.font_families.update("TimesNewRoman" => {:normal =>"app/assets/fonts/TimesNewRoman.ttf"})
    # @content_pdf.font_families.update("RobotoRegular" => {:normal =>"app/assets/fonts/Roboto-Regular.ttf"})
    @content_pdf.font_families.update("LoraWeight" => {:normal =>"app/assets/fonts/LoraWeight.ttf"})

    @out_file = out_file
    @data = data # dữ liệu để thêm vào từng page của file template
  end

  def perform
    create_content_file
    merge_content_with_template
    true
  rescue StandardError => e
    puts e
    Rails.logger.error e.message
    false
  ensure
    FileUtils.rm_f content_file
  end

  private
  def create_content_file
    # do file template có thể có nhiều page, mỗi page có size khác nhau
    # nên khi tạo file content cũng phải tạo từng page với size tương ứng
    template_pdf.pages.each_with_index do |template_page, page_idx|
      _, _, width, height = template_page.mediabox
      content_pdf.start_new_page size: [width, height], margin: PAGE_MARGIN
      puts page_idx
      # puts template_page
      puts width
      puts height
      add_content_page data[page_idx]
    end

    content_pdf.render_file content_file
  end

  def create_content_file_old
    # do file template có thể có nhiều page, mỗi page có size khác nhau
    # nên khi tạo file content cũng phải tạo từng page với size tương ứng
    template_pdf.pages.each_with_index do |template_page, page_idx|
      _, _, width, height = template_page.mediabox
      content_pdf.start_new_page size: [width, height], margin: PAGE_MARGIN
      add_content_page data[page_idx]
    end

    template_file.render_file content_file
  end

  def add_content_page page_data
    page_data.each do |input|
      puts input
      content_pdf.send input[0], *input[1..-1]
    end
  end

  def merge_content_with_template
    # merge từng page của file content với từng page của file template
    content_pages = CombinePDF.load(content_file).pages
    template_pdf.pages.each_with_index do |page, page_idx|
      page << content_pages[page_idx]
    end
    template_pdf.save out_file

  end

  def content_file
    @content_file ||= Rails.root.join "tmp", "content_#{Time.now.to_i}_#{SecureRandom.hex}.pdf"
  end
end
