class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_topic.subject
  #
  def sendmail_topic(topic)
    @greeting = "Hi"

    mail to: "alp2momo515522@yahoo.co.jp"
     subject:'【FBook】トピックが投稿されました'
  end
end
