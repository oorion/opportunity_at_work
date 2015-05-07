# Preview all emails at http://localhost:3000/rails/mailers/welcome_email
class WelcomeEmailPreview < ActionMailer::Preview
  def welcome_user
    user = Company.last.users.create(email: "mrjobman@example.com",
                                     name: "Mr. Job Man",
                                     title: "Head Dude",
                                     password: "password"
                                     )
    password = "laekjroaif3923"
    UserEmailer.send_welcome_email(user, password)
  end
end
