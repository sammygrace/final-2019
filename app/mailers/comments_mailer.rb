class CommentsMailer < ApplicationMailer
  def notify_vendor(vendor)
    @vendor = vendor
    mail to: @vendor.email, subject: "You've received a comment!"
  end
end
