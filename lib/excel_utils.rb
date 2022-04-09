module ExcelUtils

  def worksheet_name(worksheet_name)
    specials_chars = '\+\-&|!(){}[]^"~*?:\\/'
    return worksheet_name.to_s.tr(specials_chars, ' ')[0..29]
  end

  def format_rows_title(sheet_page, row_indexes = [])
    if row_indexes.present?
      format = Spreadsheet::Format.new :weight => :bold, :size => 13, :horizontal_align => :left
      row_indexes.each do |row_index|
        sheet_page.rows[row_index].default_format = format
      end
    end
  end

  def format_rows_header(sheet_page, row_indexes = [])
    if row_indexes.present?
      format = Spreadsheet::Format.new :weight => :bold, :size => 11
      row_indexes.each do |row_index|
        sheet_page.rows[row_index].default_format = format
      end
    end
  end

  def format_rows_summary(sheet_page, row_indexes = [])
    if row_indexes.present?
      format = Spreadsheet::Format.new :weight => :bold, :size => 11, :horizontal_align => :right
      row_indexes.each do |row_index|
        sheet_page.rows[row_index].default_format = format
      end
    end
  end

  def format_columns_currency(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => '$#,##0.00_);[Red]($#,##0.00)'
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_columns_date(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => 'mm/dd/yyyy'
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_columns_datetime(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => 'mm/dd/yyyy hh:mm'
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_columns_center(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :horizontal_align => :centre
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_columns_right(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :horizontal_align => :right
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_columns_wraptext(sheet_page, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :text_wrap => true
      column_indexes.each do |column_index|
        sheet_page.column(column_index).default_format = format
      end
    end
  end

  def format_cells_currency(sheet_page, row_index, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => '$#,##0.00_);[Red]($#,##0.00)'
      column_indexes.each do |column_index|
        sheet_page.row(row_index).set_format(column_index, format)
      end
    end
  end

  def format_cells_date(sheet_page, row_index, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => 'mm/dd/yyyy'
      column_indexes.each do |column_index|
        sheet_page.row(row_index).set_format(column_index, format)
      end
    end
  end

  def format_cells_datetime(sheet_page, row_index, column_indexes = [])
    if column_indexes.present?
      format = Spreadsheet::Format.new :number_format => 'mm/dd/yyyy hh:mm'
      column_indexes.each do |column_index|
        sheet_page.row(row_index).set_format(column_index, format)
      end
    end
  end


  module_function :worksheet_name
  module_function :format_rows_title
  module_function :format_rows_header
  module_function :format_rows_summary
  module_function :format_columns_currency
  module_function :format_columns_date
  module_function :format_columns_datetime
  module_function :format_columns_center
  module_function :format_columns_right
  module_function :format_columns_wraptext
  module_function :format_cells_currency
  module_function :format_cells_date
  module_function :format_cells_datetime
end