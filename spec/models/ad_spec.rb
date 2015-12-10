require "rails_helper"

describe Ad do
  
  it { is_expected.to validate_presence_of :ad_content }  
  it { is_expected.to have_many(:comments).dependent(:destroy) }
  it { is_expected.to belong_to(:member) }

  it "has a valid factory" do    
    ad = build(:ad)
    expect(ad).to be_valid
  end

  it "is invalid with image size more than 3 MB" do
    ad = build(:fail_image)
    ad.save
    expect(ad.errors[:ad_image]).to include("should be less than 3 MB")
  end

end
