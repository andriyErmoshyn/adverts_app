require "rails_helper"
require "cancan/matchers"
  
describe Ability do
  let(:admin) { create :admin }
  let(:moderator) { create :moderator }
  let(:user) { create :user }
  let(:non_logged_in_user) { create :non_logged_in_user }
  let(:member) {create :member }
  let(:member_ad) { create(:ad, member: member) }
  let(:member_comment) { create(:comment, member: member) }
  
  context "with member role admin" do
    subject { Ability.new(admin) }
    
    it { is_expected.to be_able_to(:manage, Member) }
    it { is_expected.to be_able_to(:crud, Ad) }
    it { is_expected.to be_able_to(:crud, Comment) }
    it { is_expected.not_to be_able_to(:update, member_comment) }
  end

  context "with member role moderator" do
    subject { Ability.new(moderator) }

    it { is_expected.to be_able_to(:manage, Ad) }
    it { is_expected.to be_able_to(:manage, Comment) }
    it { is_expected.to be_able_to(:update, moderator) }
    it { is_expected.to_not be_able_to(:update, member) }
  end

  context "with member role user" do
    subject { Ability.new(user) }

    it { is_expected.to be_able_to(:crud, Ad) }
    it { is_expected.to be_able_to(:crud, Comment) }
    it { is_expected.to be_able_to(:update, user) }
    it { is_expected.to_not be_able_to(:update, member) }
    it { is_expected.to_not be_able_to(:update, member_ad) }
    it { is_expected.to_not be_able_to(:destroy, member_ad) }
    it { is_expected.to_not be_able_to(:update, member_comment) }
    it { is_expected.to_not be_able_to(:destroy, member_comment) }
  end

  context "with non-logged in user" do
    subject { Ability.new(non_logged_in_user) }

    it { is_expected.to be_able_to(:create, Member) }
    it { is_expected.to_not be_able_to(:index, Member) }
    it { is_expected.to_not be_able_to(:create, Ad) }
    it { is_expected.to_not be_able_to(:update, Ad) }
    it { is_expected.to_not be_able_to(:destroy, Ad) }
    it { is_expected.to_not be_able_to(:create, Comment) }
    it { is_expected.to_not be_able_to(:update, Comment) }
    it { is_expected.to_not be_able_to(:destroy, Comment) }
  end

end
