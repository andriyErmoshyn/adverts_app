require "rails_helper"

describe "Comment" do

  let(:member) { create :member }
  let(:ad) { create :ad, member: member }
  let!(:comment) { create :comment, ad_id: ad.id, member_id: member.id }
    
  before do
    log_in_with(member.login, member.password)
    visit ad_path(ad)
  end

  describe "#create" do

    it 'creates comment' do
      expect{fill_in "comment_area", with: "First comment"
      click_button "Add a comment"
      }.to change{Comment.count}.by(1)
    end    
  end

  describe "#destroy" do
       
    it "deletes comment" do
      expect{click_link "Delete"}.to change { Comment.count }.by(-1)
    end    
  end

  describe "#update" do

    it "updates comment" do
      click_link "edit_comment_#{comment.id}"
      fill_in "comment_area", with: "New comment"
      click_button "Update comment"
      expect(comment.reload.body).to eq "New comment"
      expect(current_path).to eq ad_path(ad)
    end
  end
end
