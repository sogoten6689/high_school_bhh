class SettingsController < ApplicationController
  include ApplicationHelper
  before_action :is_signed_in?
  before_action :is_admin?
  rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

  def index
    # @settings = Setting.all
    @basic_information = Setting.where(key: 'update.information.basic.full').first
    @basic_information_birthday = Setting.where(key: 'update.information.basic.birthday').first
    @basic_information_gender = Setting.where(key: 'update.information.basic.gender').first
    @basic_information_where_born = Setting.where(key: 'update.information.basic.where_born').first
    @basic_information_ethnicity = Setting.where(key: 'update.information.basic.ethnicity').first
    @basic_information_identification = Setting.where(key: 'update.information.basic.identification').first
    @basic_information_religion = Setting.where(key: 'update.information.basic.religion').first

    @relationship_information = Setting.where(key: 'update.information.relationship.full').first
    @relationship_information_vietschool_connect_phone = Setting.where(key: 'update.information.relationship.vietschool_connect_phone').first
  end



  def update_setting

    update_basic_information_role

    if (params['update.information.relationship.full'] == 'on')
      Setting.where(key: 'update.information.relationship.full').update(value: true)
    else
      Setting.where(key: 'update.information.relationship.full').update(value: false)
    end


    if (params['update.information.relationship.vietschool_connect_phone'] == 'on')
      Setting.where(key: 'update.information.relationship.vietschool_connect_phone').update(value: true)
    else
      Setting.where(key: 'update.information.relationship.vietschool_connect_phone').update(value: false)
    end

    redirect_to  settings_path
  end

  def show
  end

  def edit
  end

  def update_basic_information_role

    if (params['update.information.basic.full'] == 'on')
      Setting.where(key: 'update.information.basic.full').update(value: true)

      # Setting.where(key: 'update.information.basic.birthday').update(value: true)
      # Setting.where(key: 'update.information.basic.gender').update(value: true)
      # Setting.where(key: 'update.information.basic.where_born').update(value: true)
      # Setting.where(key: 'update.information.basic.ethnicity').update(value: true)
      # Setting.where(key: 'update.information.basic.identification').update(value: true)
      # Setting.where(key: 'update.information.basic.religion').update(value: true)
    else
      Setting.where(key: 'update.information.basic.full').update(value: false)

      # Setting.where(key: 'update.information.basic.birthday').update(value: false)
      # Setting.where(key: 'update.information.basic.gender').update(value: false)
      # Setting.where(key: 'update.information.basic.where_born').update(value: false)
      # Setting.where(key: 'update.information.basic.ethnicity').update(value: false)
      # Setting.where(key: 'update.information.basic.identification').update(value: false)
      # Setting.where(key: 'update.information.basic.religion').update(value: false)
    end

    if (params['update.information.basic.birthday'] == 'on')
      Setting.where(key: 'update.information.basic.birthday').update(value: true)
    else
      Setting.where(key: 'update.information.basic.birthday').update(value: false)
    end

    if (params['update.information.basic.gender'] == 'on')
      Setting.where(key: 'update.information.basic.gender').update(value: true)
    else
      Setting.where(key: 'update.information.basic.gender').update(value: false)
    end

    if (params['update.information.basic.where_born'] == 'on')
      Setting.where(key: 'update.information.basic.where_born').update(value: true)
    else
      Setting.where(key: 'update.information.basic.where_born').update(value: false)
    end

    if (params['update.information.basic.ethnicity'] == 'on')
      Setting.where(key: 'update.information.basic.ethnicity').update(value: true)
    else
      Setting.where(key: 'update.information.basic.ethnicity').update(value: false)
    end

    if (params['update.information.basic.identification'] == 'on')
      Setting.where(key: 'update.information.basic.identification').update(value: true)
    else
      Setting.where(key: 'update.information.basic.identification').update(value: false)
    end

    if (params['update.information.basic.religion'] == 'on')
      Setting.where(key: 'update.information.basic.religion').update(value: true)
    else
      Setting.where(key: 'update.information.basic.religion').update(value: false)
    end
  end

  private

  def setting_params
    params.require(:setting).permit( :key, :value,)
  end
end
