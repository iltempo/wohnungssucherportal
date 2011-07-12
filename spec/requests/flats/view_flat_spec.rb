require 'spec_helper'

feature "Viewing flats" do

  scenario "clicking on a flat name shows me the details" do
    flat = Factory.create(:flat)
    visit(root_path)
    click_link(flat.street)
    page.should have_css('h2', :text => flat.street)
    page.should have_content('last changed on')
  end
  
end