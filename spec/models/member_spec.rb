require "rails_helper"

describe Member do

  let(:member) { create :member }

  it "has a valid factory" do
    expect(member).to be_valid
  end

  it { is_expected.to validate_presence_of :login }
  it { is_expected.to validate_presence_of :full_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :address }
  it { is_expected.to validate_presence_of :city }
  it { is_expected.to validate_presence_of :state}
  it { is_expected.to validate_presence_of :country }
  it { is_expected.to validate_presence_of :zip }
  it { is_expected.to validate_presence_of :password }
  it { is_expected.to validate_presence_of :password_confirmation }
      
  it { is_expected.to validate_uniqueness_of(:login).case_insensitive }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it { is_expected.to validate_length_of(:login).is_at_least(2).is_at_most(20) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }
  it { is_expected.to validate_length_of(:email).is_at_most(255) }

  it { is_expected.to have_secure_password }

  it { is_expected.to validate_confirmation_of(:password) }

  it { is_expected.to have_many(:ads).dependent(:destroy) }
  it { is_expected.to have_many(:comments) }

  it  { is_expected.to define_enum_for(:role) }

  it "should have a valid birthday" do
    member = Member.new(birthday: nil)
    member.valid?
    expect(member.errors[:birthday]).to include("should have format 'day/month/year'")
  end

  describe "email format validations" do

    it "is invalid with invalid email" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                   foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        member.email = invalid_address
        expect(member).not_to be_valid
      end
    end

    it "is valid with valid email" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        member.email = valid_address
        expect(member).to be_valid
      end
    end
  end

  describe ".authenticate" do
    subject { member }
    let(:found_member) { Member.find_by(login: member.login) }

    context "with valid password" do
      it { is_expected.to eq found_member.authenticate(member.password) }
    end

    context "with invalid password" do
      let(:member_for_invalid_password) { found_member.authenticate("invalid") }
      it { is_expected.not_to eq member_for_invalid_password }
      specify { expect(member_for_invalid_password).to be_falsey }
    end
  end

  describe "authenticated? should return false for a member with nil digest" do
    subject{ member }
    specify { expect(member.authenticated?(:reset, '')).to be_falsey }
  end
  
  describe "ads associations" do
        
    let!(:older_ads) do
      create(:ad, member: member, created_at: 1.day.ago)
    end
    let!(:newer_ads) do
      create(:ad, member: member, created_at: 1.hour.ago)
    end

    it "should have the right ads in the right order" do
      expect(member.ads).to eq [newer_ads, older_ads]
    end   
  end

  describe '#send_password_reset_email' do

    it "should be successful" do
      member.reset_token = Member.new_token
      expect{ member.send_password_reset_email }.to change{ ActionMailer::Base.deliveries.count }.by(1)
    end

  end

end
