class StudentMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.student_mailer.book_issue.subject
  #
  def book_issue(student)
    @greeting = "Hi"
    @student = student
    mail to: @student.email , subject: "Book issue"
  end
end
