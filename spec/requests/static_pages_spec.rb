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
end