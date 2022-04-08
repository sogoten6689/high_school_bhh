module AppUtils
  def json_to_array(json)
    begin
      result = JSON.parse(json.to_s) || []
    rescue Exception => e
      Rails.logger.info e.inspect
      result = []
    end

    result.kind_of?(Array) ? result : []
  end

  def json_to_hash(json)
    begin
      result = JSON.parse(json.to_s) || {}
    rescue Exception => e
      Rails.logger.info e.inspect
      result = {}
    end

    result.kind_of?(Hash) ? result : {}
  end

  def json_to_hash_with_symbolize_names(json)
    begin
      result = JSON.parse(json.to_s, :symbolize_names => true) || {}
    rescue Exception => e
      Rails.logger.info e.inspect
      result = {}
    end

    result.kind_of?(Hash) ? result : {}
  end

  def strings_to_dates(strings)
    result = []
    strings.each do |string|
      date = Date.parse(string) rescue nil
      result << date if date
    end
    result
  end

  # Quote string to avoid sql injection
  def quote_string(v)
    v.to_s.gsub(/\\/, '\&\&').gsub(/'/, "''")
  end

  def escape_search_query(query)
    return '' if query.blank?

    specials_chars = '\+\-&|!(){}[]^"~*?:\\/'
    query.to_s.tr(specials_chars, ' ').strip
  end


  def format_address(address)
    address_val = ''

    unless address.blank?
      address_val = "#{address.line_1}" unless address.line_1.blank?
      address_val += ", #{address.city}" unless address.city.blank?
      address_val += ", #{address.state.abbr}" unless address.state.nil?
      address_val += ", #{address.country.name}" unless (address.country.nil? || address.country.id == 1)
    end

    address_val
  end

  def format_city_state(address)
    address_val = ''

    unless address.blank?
      address_val = "#{address.city}" unless address.city.blank?
      address_val += ", #{address.state.name}" unless address.state.nil?
    end

    address_val
  end

  def address_decoration(address_1, city, state, zip, country)
    address_1 = "#{address_1}<br />" unless address_1.blank?
    address_city_state_zip = "#{city}, " unless city.blank?
    address_city_state_zip += "#{state}, " unless state.blank?
    address_city_state_zip += "#{zip}" unless zip.blank?
    address_city_state_zip += '<br />' unless address_city_state_zip.blank?
    address_country = "#{country.name}" if country != nil && country.id != 1
    "#{address_1} #{address_city_state_zip} #{address_country}"
  end

  def short_address_decoration(city_name, state, country)
    address_string = ''
    address_string = "#{city_name}" if city_name.present?
    address_string += ", #{state.abbr}" if state.present? && state.abbr.present?
    address_string += ", #{country.name}" if country != nil && country.id != 1
    address_string
  end

  def valid_email?(email)
    email.present? && VALID_EMAIL_REGEX.match(email).present?
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def convert_checkin_list_excel_file_to_array(spreadsheet)
    success = false
    message = []
    rows = Array.new
    begin
      header = spreadsheet.row(1)
      if header[0] != 'Email' || header[1] != 'First Name' || header[2] != 'Last Name' || header[3] != 'Phone'
        message << {:row => 0, :error => 'Wrong format'}
      else
        email_list = Array.new
        (2..spreadsheet.last_row).each do |i|
          if Utils.valid_email?(spreadsheet.row(i)[0]) && !email_list.include?(spreadsheet.row(i)[0]) && !spreadsheet.row(i)[1].to_s.blank? && !spreadsheet.row(i)[2].to_s.blank?
            rows << spreadsheet.row(i)
            email_list << spreadsheet.row(i)[0]
          else
            row_number = "#{i}"
            error_message = ''
            if email_list.include?(spreadsheet.row(i)[0])
              error_message += I18n.t('excel_import_file_email_existed')
            else
              if !Utils.valid_email?(spreadsheet.row(i)[0])
                error_message += I18n.t('error.invalid_email')
              end
              if spreadsheet.row(i)[1].to_s.blank?
                error_message += I18n.t('excel_import_file_wrong_first_name')
              end
              if spreadsheet.row(i)[2].to_s.blank?
                error_message += I18n.t('excel_import_file_wrong_last_name')
              end
            end
            message << {:row => row_number, :error => error_message}
          end
        end
        if message.blank?
          success = true
        end
      end
    rescue Exception => e
      Rails.logger.info e.inspect
      message << e.inspect
    end

    {
        :success => success,
        :message => message,
        :data => rows
    }
  end

  def last_digits(number)
    number.to_s.length <= 4 ? number : number.to_s.slice(-4..-1)
  end

  def mask_number(number)
    "xxxx-xxxx-xxxx-#{last_digits(number)}"
  end

  def mask_email(email)
    return '' if email.blank? || email.index('@').nil?

    begin_index = 1
    end_index = email.index('@') - 2

    return email if end_index < begin_index

    number_of_mask_chacters = end_index - begin_index + 1
    email.sub(email[begin_index, number_of_mask_chacters], '*' * number_of_mask_chacters)
  end

  def convert_params_to_hash(*args)
    result = Hash.new
    begin
      if args[0].present?
        args[0].each { |name, value| result[name] = value }
      end
    rescue Exception => e
      Rails.logger.info e.inspect
    end

    result
  end

  def get_short_url(url)
    begin
      return Bitly.client.shorten(url).short_url || ''
    rescue
      return ''
    end
  end

  def get_root_url(request, event)
    begin
      protocol = request.protocol
      port = request.port
      host_with_port = request.host_with_port
      domain_name = event.domain_name
      domain_name = protocol + host_with_port if domain_name.blank?
      domain_name = protocol + domain_name if domain_name.exclude?(protocol)
      # domain_name = domain_name + ":#{port}" if domain_name.exclude?(port.to_s)
      temp = domain_name.length - 1
      domain_name = domain_name[0...temp] if domain_name[temp] == '/'
      domain_name
    rescue
      return ''
    end
  end

  def get_admin_url(request, event)
    begin
      protocol = request.protocol

      if event && event.brand && event.brand.admin_url.present?
        admin_url = event.brand.admin_url
      else
        hosts = request.host_with_port.split('.')
        hosts -= [hosts[0]]
        hosts = ['admin'] + hosts
        admin_url = hosts.join('.')
      end
     
      admin_url = protocol + admin_url if admin_url.exclude?(protocol)
      temp = admin_url.length - 1
      admin_url = admin_url[0...temp] if admin_url[temp] == '/'
      admin_url
    rescue
      return ''
    end
  end

  # Round up input number next 9
  # @param [Object] number: input number
  # All number will be rounded-up to the nearest "9" in the dollar range.
  # For example:
  # * if less than 10.00 == do not change
  # * 12.34 = 19.00
  # * 123.45 = 129.00
  # * 1234.56 = 1239.00
  # * 12345.67 = 12349.00
  # * 123456.78 = 123459.00
  # * 123459.78 = 123469.00
  def round_up_next_9(number)
    number.to_f < 10 ? number.to_f : (((number.to_f + 1) / 10).ceil * 10 - 1).to_f
  end

  def convert_time_to_timezone(time, time_zone_name)
    temp = Time.zone

    Time.zone = time_zone_name
    result = Time.zone.parse("#{time.year}-#{time.month}-#{time.day} #{time.hour}:#{time.min}")
    Time.zone = temp
    return result

  rescue Exception => e
    Rails.logger.info e.inspect
    return nil
  end

  def format_long_date(date)
    return date.strftime('%A, %b %d, %Y')
  rescue
    return ''
  end

  def format_short_date(date)
    return date.strftime('%b %d, %Y')
  rescue
    return ''
  end

  def format_timestamp(date)
    return date.strftime('%Y-%m-%d %H:%M')
  rescue
    return ''
  end

  def format_utc_date(date)
    return date.to_date.strftime('%Y-%m-%d')
  rescue
    return ''
  end

  def to_time(date)
    return date.strftime('%H:%M')
  rescue
    return ''
  end
  def to_day_month(date)
    return date.strftime('%b %d')
  rescue
    return ''
  end
  def format_date_time(date_time)
    return date_time.to_datetime.strftime('%b %d, %Y %H:%M')
  rescue
    return ''
  end

  def time_difference_in_hours(utc_time, timezone_time)
    return 0 if utc_time.nil? || timezone_time.nil?
    ((utc_time.utc_offset - timezone_time.utc_offset)/3600).abs
  end

  def time_difference_in_seconds(from_time, to_time)
    return 0 if from_time.nil? || to_time.nil? || from_time >= to_time
    (to_time - from_time).to_i
  end

  def timezone_query(date_time_column_name)
    "(#{date_time_column_name} AT TIME ZONE 'UTC') AT TIME ZONE '#{Time.zone.name}'"
  end

  def round_amount(amount)
    BigDecimal((amount * 100).round)/100
  end

  def arrays_have_common_elements?(array1, array2)
    (array1 & array2).length > 0
  end

  def week_of_the_month(date)
    date.strftime('%U').to_i - date.beginning_of_month.strftime('%U').to_i + 1
  end

  def format_currency(amount, symbol, code)
    "#{symbol}#{amount.round(2)} #{code}"
  end

  def convert_slug_to_text(slug)
    slug.titleize
  end

  module_function :json_to_array
  module_function :json_to_hash
  module_function :strings_to_dates
  module_function :escape_search_query
  module_function :format_address
  module_function :format_city_state
  module_function :address_decoration
  module_function :short_address_decoration
  module_function :open_spreadsheet
  module_function :convert_checkin_list_excel_file_to_array
  module_function :valid_email?
  module_function :mask_email
  module_function :last_digits
  module_function :mask_number
  module_function :json_to_hash_with_symbolize_names
  module_function :convert_params_to_hash
  module_function :get_short_url
  module_function :quote_string
  module_function :round_up_next_9
  module_function :convert_time_to_timezone
  module_function :format_long_date
  module_function :format_short_date
  module_function :format_date_time
  module_function :format_timestamp
  module_function :time_difference_in_hours
  module_function :time_difference_in_seconds
  module_function :to_time
  module_function :to_day_month
  module_function :timezone_query
  module_function :get_root_url
  module_function :get_admin_url
  module_function :round_amount
  module_function :arrays_have_common_elements?
  module_function :week_of_the_month
  module_function :format_currency
  module_function :convert_slug_to_text
  module_function :format_utc_date
end