class ElectiveSubjectsController < ApplicationController
    include ApplicationHelper
    before_action :is_signed_in?
    rescue_from ActiveRecord::InvalidForeignKey, with: :invalid_foreign_key

    def index
        @elective_subject = ElectiveSubject.find_by(:user_id => current_user.id)
    end

    def create
        begin
            if params[:group_subject].blank? || params[:thematic_group].blank? || params[:elective_subject_one].blank? || params[:elective_subject_two].blank?
                flash[:error] = 'Missing data, please try again later.'
                return redirect_to request.referer
            end

            alternative_subject = ['tc1.2.3', 'tc1.2.4', 'tc2.2.3', 'tc2.2.4', 'tc3.2.3', 'tc3.2.4'].any?{|v| v == params[:elective_subject_two]}

            if alternative_subject && params[:alternative_subject].blank?
                flash[:error] = 'Missing alternative_subject, please try again later.'
                return redirect_to request.referer
            end
            params[:alternative_subject] = nil if !alternative_subject

            elective_subject = ElectiveSubject.find_by(:user_id => current_user.id)
            send_mail = false
            email_subject = ''
            is_update = false

            if elective_subject.blank?
                ElectiveSubject.create!(
                    :group_subject => params[:group_subject],
                    :thematic_group => params[:thematic_group],
                    :elective_subject_one => params[:elective_subject_one],
                    :elective_subject_two => params[:elective_subject_two],
                    :alternative_subject => params[:alternative_subject],
                    :user_id => current_user.id,
                    :editable => true
                )
                flash[:success] = 'Đã đăng ký thành công!'
                email_subject= 'Đăng ký môn tự chọn thành công!'
                send_mail = true
            else
                if elective_subject.editable
                    elective_subject.update!(
                      :group_subject => params[:group_subject],
                      :thematic_group => params[:thematic_group],
                      :elective_subject_one => params[:elective_subject_one],
                      :elective_subject_two => params[:elective_subject_two],
                      :alternative_subject => params[:alternative_subject],
                      :editable => true
                    )
                    flash[:success] = 'Đã cập nhập thành công!'
                    email_subject= 'Cập nhập môn tự chọn thành công!'
                    send_mail = true
                    is_update = true
                else
                    flash[:error] = 'Hết hạn cập nhật!'
                end

                if send_mail
                    email_params = {
                                        :name => current_user[:name],
                                        :group_subject => GROUP_SUBJECT.select{|g| g[:code] == params[:group_subject]}.first[:name],
                                        :thematic_group => THEMATIC_GROUP.select{|g| g[:code] == params[:thematic_group]}.first[:name],
                                        :elective_subject_one => ELECTIVE_SUBJECT_ONE.select{|g| g[:code] == params[:elective_subject_one]}.first[:name],
                                        :elective_subject_two => ELECTIVE_SUBJECT_TWO.select{|g| g[:code] == params[:elective_subject_two]}.first[:name],
                                        :alternative_subject => params[:alternative_subject].present? ? ALTERNATIVE_SUBJECT.select{|g| g[:code] == params[:alternative_subject]}.first[:name] : nil,
                                        :is_update => is_update
                                    }
                    ElectiveSubjectsMailer.send_registration_confirmation(email_params, current_user.email, email_subject).deliver
                end
            end
        rescue Exception => ex
            Rails.logger.info(ex.message)
            flash[:error] = ex.message
        end
        redirect_to request.referer
    end
end