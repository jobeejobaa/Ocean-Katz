class ContactMailer < ApplicationMailer
  def contact_email(name, email, message)
    @name = name
    @email = email
    @message = message

    mail(to: ENV.fetch("CONTACT_TO", ENV.fetch("GMAIL_USER", "from@example.com")), subject: "Nouveau message du site")
  end
end
