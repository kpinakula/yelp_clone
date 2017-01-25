require 'rails_helper'

feature 'reviews' do
    scenario 'Lets the user add a review using a form' do
      Restaurant.create(name: 'KFY', description: 'yaks')
      visit '/restaurants'
      click_link 'Review KFY'
      fill_in 'Comment', with: 'yikes'
      select '3', from: 'Rating'
      click_button 'Leave Review'

      expect(current_path).to eq '/restaurants'
      expect(page).to have_content('yikes') 
    end
end