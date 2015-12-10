class MemberMailer < ApplicationMailer

  def password_reset(member)
    @member = member

    mail to: member.email, subject: "Password reset"
  end
end
