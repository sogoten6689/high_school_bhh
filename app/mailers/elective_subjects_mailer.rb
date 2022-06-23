class ElectiveSubjectsMailer < ApplicationMailer
    default from: "no_reply@thptbinhhunghoa.edu.vn"
    def send_registration_confirmation(email_params, to = TEST_EMAIL, subject = '')
        @email_params = email_params
        mail_headers = {:to => to, :subject => subject}
        mail_headers[:from] = @email_params[:from] if @email_params[:from].present?
        mail(mail_headers)
    end
end
