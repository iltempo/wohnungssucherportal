require 'spec_helper'

feature "Sorting flats" do

  scenario "Sorting by price descending works" do
    Factory.create(:flat, :street => 'Cheap', :price => 300)
    Factory.create(:flat, :street => 'Expensive', :price => 500, :created_at => Time.now - 1.minute)
    visit(root_path)
    within("#flats") do
      # by default, the most recently created flat comes first (created_at DESC)
      find(:tr, 2).should have_content("Cheap")
      find(:tr, 3).should have_content("Expensive")
    end
    click_on('price')
    within("#flats") do
      # price is configured to sort descending (price DESC)
      find(:tr, 2).should have_content("Expensive")
      find(:tr, 3).should have_content("Cheap")
    end
  end
  
end