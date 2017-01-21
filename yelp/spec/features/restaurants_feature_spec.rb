require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do
    # this is a test vvvv
    scenario 'should display a prompt to add a restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end

    # this is another test vvvv
    # ...
  end
  
  context 'restaurants have  been added' do
    before do
      Restaurant.create(name: 'KFC')
    end
    
    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    scenario 'prompts user to fill out a form, then displays the new restaurant' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      fill_in 'Description', with: 'Chikken'
      click_button 'Create Restaurant'
      expect(page).to have_content 'KFC'
      expect(page).to have_content 'Chikken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'viewing restaurants' do
    let!(:bfff){ Restaurant.create(name: 'Baba\'s Fancy Food Feast', description: 'Awesome feasts from the Far Easts') }

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'Baba\'s Fancy Food Feast'
      expect(page).to have_content 'Baba\'s Fancy Food Feast'
      expect(page).to have_content "#{bfff.description}"
      expect(current_path).to eq "/restaurants/#{bfff.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Chikken', id: 1 }

    scenario 'let a user edit a restaurant' do
      visit '/restaurants'
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Chikkennnnn'
      click_button 'Update Thissssssssss'
      click_link 'Kentucky Fried Chicken'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Chikkennnnn'
      expect(current_path).to eq '/restaurants/1'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create name: 'KFC', description: 'Chikken' }

    scenario 'let a user delete a restaurant' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).not_to have_content 'Chikken'
      expect(page).to have_content 'Restaurant deleted successfully'
      expect(current_path).to eq '/restaurants'
    end
  end
end