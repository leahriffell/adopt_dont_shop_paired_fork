require 'rails_helper'

RSpec.describe 'favorites index page' do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )

    @pet_1 = Pet.create!(
                          image: "http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg",
                          name: "Fluffy",
                          approximate_age: "15 weeks",
                          sex: "Female",
                          shelter_id: @shelter_1.id,
                          description: "I am fluffy and so cute. I need someone to be my friend forever!!",
                          adoption_status: "adoptable",
                        )
  end

  it 'can see all pets favorited' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    within ".pet#{@pet_1.id}" do
      expect(page).to have_link(@pet_1.name)
      expect(page).to have_css("img[src*='http://3.bp.blogspot.com/-72agMABPgDw/Tx-76OX1SWI/AAAAAAAAAB4/OYmSC3j-4S8/s400/5.jpg']")
    end
  end

  it 'can see pet show page when clicked on' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    click_link 'Fluffy'

    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it 'can remove pet from favorites' do
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_link("Add to Favorites")
    click_link "Add to Favorites"

    visit '/favorites'

    within ".pet#{@pet_1.id}" do
      expect(page).to have_link("Remove from Favorites")
      click_link "Remove from Favorites"
    end

    expect(page).to have_current_path('/favorites')
    expect(page).to have_no_content(@pet_1.name)

    within('nav') do
      expect(page).to have_link("Favorites(0)")
    end
  end

  it 'see text saying I have no favorited pets' do

    visit '/favorites'

    expect(page).to have_content('No Furry Friends Here Yet')
  end

  it 'can remove all from favorited pets' do
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit '/favorites'

    expect(page).to have_link("Remove All Pets From Favorites")

    click_link "Remove All Pets From Favorites"

    expect(page).to have_current_path("/favorites")
    expect(page).to have_content('No Furry Friends Here Yet')
    expect(page).to have_no_link("Remove All Pets From Favorites")
    expect(page).to have_link("Favorites(0)")
  end

  it 'can see link for adopting favorite pets' do
    visit "/pets/#{@pet_1.id}"
    click_link "Add to Favorites"

    visit '/favorites'
    expect(page).to have_link("Apply to adopt")
    click_link "Apply to adopt"
    expect(page).to have_current_path("/applications/new")
  end
end
