class ApplicationMailer < ActionMailer::Base
  default from: 'lamnguyen04.97@gmail.com'
  layout 'mailer'

  def send_password(user, password)

    @hello = "Hello " + user.full_name + "!"
    @welcome = "Welcome to BHH HIGH SCHOOL, please use your below credentials to login:"
    @account = "Your account: " + user.email
    @password = "Your password: " + password

    @login_text = t('login')
    mail(to: user.email, subject: "Welcome to BHHH!")
  end
end
