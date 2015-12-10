require 'rails_helper'

describe "MemberMailer " do

  let!(:member) { create :member }

  it "sends member a reset token" do
    member.reset_token = Member.new_token
    mail = MemberMailer.password_reset(member)
    expect(mail.subject).to eq "Password reset"
    expect(mail.to).to eq [member.email]
    expect(mail.from).to eq ["from@example.com"]
    expect(mail.body.encoded).to have_link "Reset password"
    expect(mail.body.encoded).to have_content member.reset_token
  end

end
