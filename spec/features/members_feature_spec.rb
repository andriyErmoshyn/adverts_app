require 'rails_helper'

describe "Member" do
  let (:admin) { create :admin }
  let(:moderator) { create :moderator }
  let(:user) {create :user }
  let(:member) {build :member }

  describe "when signs up" do
    it "should see sign up link" do
      visit signup_path
      expect(page). to have_content("Sign up")
    end

    context "with valid data" do
      it "should sign up successfully" do
        expect{
        visit signup_path
        fill_in "Login", with: "James"
        fill_in "Full name", with: "James Bond"
        fill_in "Birthday", with: "01.01.2000"
        fill_in "Email", with: "test@email.com"
        fill_in "Address", with: " 15 Sobornaya str."
        fill_in "City", with: "Vinnitsa"
        fill_in "State", with: "Vinnitsa"
        fill_in "Country", with: "Ukraine"
        fill_in "Zip", with: "23001"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        click_button "Sign up"}.to change(Member, :count).by(1)
        
        expect(page).to have_content("You signed up successfully!")
        expect(current_path).to eq root_path
        expect(page).to have_link("Place ad", href: new_ad_path)
        expect(page).to have_link("Members", href: members_path)
        expect(page).to have_link("Log out", href: logout_path)
        expect(page).to have_selector("#profile_link", text:"James's profile")
      end
    end

    context "with invalid data" do
      it "should render signup page" do
        visit signup_path
        fill_in "Login", with: "Unlogged"
        fill_in "Full name", with: ""
        click_button "Sign up"

        expect(page).to have_content("Sign up")
        expect(page).to have_css('div.alert.alert-danger', text: "Something went wrong. Try again, please.")
      end
    end
  end

  describe "log in" do
    
    let!(:member) { create :member }  

    it "with valid login and password" do
      log_in_with(member.login, member.password)

      expect(page).to have_content("You logged in successfully!")
      expect(current_path).to eq root_path
    end

    it "with unvalid login" do
      log_in_with("Nobody", "password")
      expect(page). to have_content("Invalid login/password information.")
    end

    it "with unvalid password" do
      log_in_with(member.login, "invalid_password")
      expect(page). to have_content("Invalid login/password information.")
    end

  end

  describe "log out" do
    
    let!(:member) { create :member }

    it "logs out successfully" do
      log_in_with(member.login, member.password)
      click_link "Log out"
      expect(current_path).to eq root_path
    end
  end

  describe "as an admin" do
    
    context "when logged in" do
      it "should see admin message" do
        log_in_with(admin.login, admin.password)
        expect(page).to have_selector(".admin_message", text: "You logged in as an admin")
      end
    end

    context "when visits members page" do
      
      before do
        log_in_with(admin.login, admin.password)
      end

      let!(:member) { create :member }

      it "should see edit and destroy links" do
        visit members_path
        expect(page).to have_link("Edit profile", href: edit_member_path(member))
        expect(page).to have_link("Delete", href: member_path(member))
      end

      it "should render edit member page" do
        visit members_path
        click_link("Edit profile", href: edit_member_path(member))
        expect(page).to have_content("Edit profile")
      end

      it "should be able to edit member's profile" do
        visit edit_member_path(member)
        fill_in "Full name", with: "New name"
        fill_in "Password", with: "password"
        fill_in "Confirm password", with: "password"
        click_button "Update profile"

        expect(page).to have_content("Profile updated")
        expect(member.reload.full_name).to eq "New name"
      end

      it "should be able to delete member" do
        visit members_path
        expect{click_link("Delete", href: member_path(member))}.to change(Member, :count).by(-1)
        expect(page).to have_content("Member deleted")
      end
    end
  end

  describe "as a moderator" do
    
    context "when logged in" do
      before do
        log_in_with(moderator.login, moderator.password)
      end

      let!(:member) { create :member }
      let!(:ad) { create(:ad, member: member) }
      let!(:own_ad) { create(:ad, member: moderator) }
       
      context "with members' ads" do
        it "should see edit and delete links" do
          visit ad_path(ad)
          expect(page).to have_link("Destroy")
          expect(page).to have_link("Edit")
        end

        it "should be able to delete members' ad" do
          visit ad_path(ad)
          expect{click_link("Destroy")}.to change(member.ads, :count).by(-1)
          expect(current_path).to eq root_path
        end

        it "should be able to edit members' ads' text" do
          visit edit_ad_path(ad)
          fill_in "ad_ad_content", with: "New text"
          click_button "Edit ad"
          expect(page).to have_selector("p", text: "New text")
          expect(ad.reload.ad_content).to eq "New text"
          expect(current_path).to eq ad_path(ad)
        end
      end

      context "with his own ads" do
        it "should see edit and delete links" do
          visit ad_path(own_ad)
          expect(page).to have_link("Destroy")
          expect(page).to have_link("Edit")
        end

        it "should be able to delete own ad" do
          visit ad_path(own_ad)
          expect{click_link("Destroy")}.to change(moderator.ads, :count).by(-1)
          expect(current_path).to eq root_path
        end

        it "should be able to edit own ads' text" do
          visit edit_ad_path(own_ad)
          fill_in "ad_ad_content", with: "Really new text"
          click_button "Edit ad"
          expect(page).to have_selector("p", text: "Really new text")
          expect(own_ad.reload.ad_content).to eq "Really new text"
          expect(current_path).to eq ad_path(own_ad)
        end
      end
    end
  end

  describe "as a user" do
        
    context "with valid data" do
      it "should be able to create ad" do
        log_in_with(user.login, user.password)
        expect{visit new_ad_path
        fill_in "ad_ad_content", with: "Test ad"
        click_button "Post"}.to change(Ad, :count).by(1)
        expect(current_path).to eq root_path
        expect(page).to have_css('div.alert.alert-success', text: "The ad was successfully created!")
      end
    end

    context "with invalid data" do      
      it "should be able to create ad" do
        log_in_with(user.login, user.password)
        visit new_ad_path
        fill_in "ad_ad_content", with: ""
        click_button "Post"
        expect(page).to have_css('div.alert.alert-warning', text: "Try again please.")
      end
    end

  end

  describe "as a non-logged in user" do
    
    context "when tries to visit restricted page" do
      it "should have warning flash" do
        visit members_path
        expect(page).to have_css("div.alert.alert-warning", text: "Sorry, you have no rights for this action.")
        expect(current_path).to eq root_path
      end
    end
  end
 
  describe "omniauth" do
    before { visit root_path }
     
    it "should sign up with facebook" do
      set_omniauth(:facebook)
      expect{click_link "facebook-link"}.to change(Member, :count).by(1)
      expect(page).to have_content("Welcome, soc_net_user!")
      expect(Member.last.provider).to eq "facebook"
    end

    it "should sign up with twitter" do
      set_omniauth(:twitter)
      expect{click_link "twitter-link"}.to change(Member, :count).by(1)
      expect(page).to have_content("Welcome, soc_net_user!")
      expect(Member.last.provider).to eq "twitter"
    end
    
  end

  describe "PasswordResets " do
    let!(:member) { create :member }
    describe "#create" do

      before do
        visit new_password_reset_path
      end

      context "with valid email" do

        it "sends member a password reset link" do          
          fill_in "Email", with: member.email
          click_button("Submit")
          expect(page).to have_content("Email sent with password reset instructions")
        end
      end

      context "with invalid email" do

        it "shows the error message" do
          fill_in "Email", with: "ivalid_email"
          click_button("Submit")
          expect(page).to have_content("Email address not found")
        end
      end
    end
  end
end
