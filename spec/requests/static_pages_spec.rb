require 'spec_helper'

describe "StaticPages" do

  subject { page }



  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }

    let(:heading) { 'How Many Squat Racks?' }
    let(:page_title) { 'Gym Reviews for Weightlifters' }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
      
    let(:heading) { 'About' }
    let(:page_title) { 'About' }

    it_should_behave_like "all static pages"
  end

  describe "Sign up page" do
    before { visit signup_path }

    let(:heading) { 'Sign Up' }
    let(:page_title) { 'Sign Up' }

    it_should_behave_like "all static pages"
  end

  it "should have the right links in the header" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Sign Up"
    expect(page).to have_title(full_title('Sign Up'))
    click_link "Home"
    expect(page).to have_title(full_title('Gym Reviews for Weightlifters'))
  end
end