require 'rails_helper'

describe "Ad" do

  describe ".search" do
    let(:first_author){ create(:member, login: "Mr_first") }
    let(:second_author){ create(:member, login: "Mr_second", address: "Pirohova") }

    before do
      3.times { first_author.ads.create(ad_content: "Three cups of coffee") }
      2.times { second_author.ads.create(ad_content: "#Two cups of tea") }
    end
    
    context "by text" do
      it "should find 3 ads" do
        visit root_path
        fill_in "search", with: "coffee"
        click_button "Search"

        expect(page). to have_content("3 ads found")
      end
    end

    context "by author" do
      it "should find 2 ads" do
        visit root_path
        fill_in "search", with: "Mr_second"
        click_button "Search"

        expect(page). to have_content("2 ads found")
      end
    end

    context "by address" do
      it "should find 2 ads" do
        visit root_path
        fill_in "search", with: "Pirohova"
        click_button "Search"

        expect(page). to have_content("2 ads found")
      end
    end
  end
end
