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

            if elective_subject.blank?
                ElectiveSubject.create!(
                    :group_subject => params[:group_subject],
                    :thematic_group => params[:thematic_group],
                    :elective_subject_one => params[:elective_subject_one],
                    :elective_subject_two => params[:elective_subject_two],
                    :alternative_subject => params[:alternative_subject],
                    :user_id => current_user.id
                )
                flash[:success] = 'Đã đăng ký thành công!'
            else
                elective_subject.update!(
                    :group_subject => params[:group_subject],
                    :thematic_group => params[:thematic_group],
                    :elective_subject_one => params[:elective_subject_one],
                    :elective_subject_two => params[:elective_subject_two],
                    :alternative_subject => params[:alternative_subject]
                )
                flash[:success] = 'Đã cập nhập thành công!'
            end
        rescue Exception => ex
            Rails.logger.info(ex.message)
            flash[:error] = ex.message
        end
        redirect_to request.referer
    end
end