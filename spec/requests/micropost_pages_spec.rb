require 'spec_helper'

describe "Micropost Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') } 
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Post" }.to change(Micropost, :count).by(1)
      end
    end
  end
  
  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a micropost" do
        expect { click_link "Delete" }.to change(Micropost, :count).by(-1)
      end
    end

    describe "as a user" do
      let!(:user2) {FactoryGirl.create(:user)}
      let!(:new_micropost) {FactoryGirl.create(:micropost, user: user2)}
      before do
        visit user_path(user2)
      end

      it { should_not have_link('Delete') }

      it "should not be able to delete other users micropost" do
        expect { delete micropost_path(new_micropost) }.not_to change(Micropost, :count)
      end
    end
  end

  describe "pagination" do

      before do
        50.times do 
          FactoryGirl.create(:micropost, user: user)
        end 
        visit root_path
      end

      it { should have_selector('div.pagination') }

      it "should list each user" do
        user.microposts.paginate(page: 1).each do |micropost|
          page.should have_selector('li', text: micropost.content)
        end
      end
    end
end
