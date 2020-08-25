require 'rails_helper'

RSpec.describe "show shelter by id page", type: :feature do
  before :each do
    @shelter_1 = Shelter.create!(
                                  name: "Rocky Mountain Puppy Rescue",
                                  address: "10021 E Iliff Ave",
                                  city: "Aurora",
                                  state: "CO",
                                  zip: "80247"
                                )
  end

  it "can see the shelter's name and address" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_1.address)
    expect(page).to have_content(@shelter_1.city)
    expect(page).to have_content(@shelter_1.state)
    expect(page).to have_content(@shelter_1.zip)
  end

  it "can link back to shelter index" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters")
  end

  it "can link to form for updating its attributes" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit")
  end

  it "can link to all of its pets" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/pets")
  end

  it "can be deleted" do

    visit "/shelters/#{@shelter_1.id}"

    click_link "Delete Shelter"

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content(@shelter_1.name)
    # expectation above assumes that shelter names are unique
  end

  it "can see list of reviews" do
    @review = @shelter_1.reviews.create!(
                              title: "Mountains of Love <3!",
                              rating: 5,
                              content: "Super clean, well-facilitated, and healthy pups.",
                              optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg",
                            )

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_content(@review.title)
    expect(page).to have_content(@review.rating)
    expect(page).to have_content(@review.content)
    expect(page).to have_css("img[src*=heart-4]")
  end

  it "can see a link to add a new review" do

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/add_review")

    click_link "Add Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/add_review")
  end

  it "can see a link to edit review" do

    @review = @shelter_1.reviews.create!(
                              title: "Mountains of Love <3!",
                              rating: 5,
                              content: "Super clean, well-facilitated, and healthy pups.",
                              optional_picture: "https://static.boredpanda.com/blog/wp-content/uuuploads/tuna-funny-dog-tunameltsmyheart/tuna-funny-dog-tunameltsmyheart-4.jpg",
                            )

    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link(href: "/shelters/#{@shelter_1.id}/edit_review/#{@review.id}")

    click_link "Edit Review"

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/edit_review/#{@review.id}")
  end


end
