require 'rails_helper'

RSpec.describe "Search result list page", type: :feature do

  before do
    @building_abc = FactoryBot.create :building, name: "Building ABC"
    @abc_building = FactoryBot.create :building, name: "ABC Building"
    @building_xyz = FactoryBot.create :building, name: "Building XYZ"

    @room_abc = FactoryBot.create :room, name: "Room ABC"
    @abc_room = FactoryBot.create :room, name: "ABC Room"
    @room_xyz = FactoryBot.create :room, name: "Room XYZ"

    @curie = FactoryBot.create :person, first_name: "Marie", last_name: "Curie"
    @riemann = FactoryBot.create :person, first_name: "Bernhard", last_name: "Riemann"
    @bernoulli = FactoryBot.create :person, first_name: "Daniel", last_name: "Bernoulli"
  end

  it "shows buildings matching the query" do
    visit search_results_path(query: "xy")
    expect(page).to have_text(@building_xyz.name)
    expect(page).to have_link(href: building_path(@building_xyz))

    visit search_results_path(query: "ABC")
    expect(page).to have_text(@building_abc.name)
    expect(page).to have_link(href: building_path(@building_abc))
    expect(page).to have_text(@abc_building.name)
    expect(page).to have_link(href: building_path(@abc_building))
  end

  it "does not show buildings not matching the query" do
    visit search_results_path(query: "xy")
    expect(page).not_to have_text(@building_abc.name)
    expect(page).not_to have_link(href: building_path(@building_abc))
    expect(page).not_to have_text(@abc_building.name)
    expect(page).not_to have_link(href: building_path(@abc_building))

    visit search_results_path(query: "ABC")
    expect(page).not_to have_text(@building_xyz.name)
    expect(page).not_to have_link(href: building_path(@building_xyz))
  end

  it "lists buildings starting with the query before other found buildings" do
    visit search_results_path(query: "ABC")
    expect(page.body.index(@abc_building.name)).to be < page.body.index(@building_abc.name)

    visit search_results_path(query: "build")
    expect(page.body.index(@building_abc.name)).to be < page.body.index(@abc_building.name)
  end

  it "shows rooms matching the query" do
    visit search_results_path(query: "xyz")
    expect(page).to have_text(@room_xyz.name)
    expect(page).to have_link(href: room_path(@room_xyz))

    visit search_results_path(query: "AB")
    expect(page).to have_text(@room_abc.name)
    expect(page).to have_link(href: room_path(@room_abc))
    expect(page).to have_text(@abc_room.name)
    expect(page).to have_link(href: room_path(@abc_room))
  end

  it "does not show rooms not matching the query" do
    visit search_results_path(query: "xyz")
    expect(page).not_to have_text(@room_abc.name)
    expect(page).not_to have_link(href: room_path(@room_abc))
    expect(page).not_to have_text(@abc_room.name)
    expect(page).not_to have_link(href: room_path(@abc_room))

    visit search_results_path(query: "AB")
    expect(page).not_to have_text(@room_xyz.name)
    expect(page).not_to have_link(href: room_path(@room_xyz))
  end

  it "lists rooms starting with the query before other found rooms" do
    visit search_results_path(query: "ABC")
    expect(page.body.index(@abc_room.name)).to be < page.body.index(@room_abc.name)

    visit search_results_path(query: "room")
    expect(page.body.index(@room_abc.name)).to be < page.body.index(@abc_room.name)
  end

  it "shows people whose first name matches the query" do
    visit search_results_path(query: "marie")
    expect(page).to have_text(@curie.name)
    expect(page).to have_link(href: person_path(@curie))

    visit search_results_path(query: "bern")
    expect(page).to have_text(@bernoulli.name)
    expect(page).to have_link(href: person_path(@bernoulli))
  end

  it "shows people whose last name matches the query" do
    visit search_results_path(query: "CUrIe")
    expect(page).to have_text(@curie.name)
    expect(page).to have_link(href: person_path(@curie))

    visit search_results_path(query: "bern")
    expect(page).to have_text(@riemann.name)
    expect(page).to have_link(href: person_path(@riemann))
  end

  it "shows people whose full name matches the query" do
    visit search_results_path(query: "Daniel Bernoulli")
    expect(page).to have_text(@bernoulli.name)
    expect(page).to have_link(href: person_path(@bernoulli))

    visit search_results_path(query: "ernhard Riem")
    expect(page).to have_text(@riemann.name)
    expect(page).to have_link(href: person_path(@riemann))
  end

  it "does not show people whose first, last and full name do not match the query" do
    visit search_results_path(query: "marie")
    expect(page).not_to have_text(@bernoulli.name)
    expect(page).not_to have_link(href: person_path(@bernoulli))
    expect(page).not_to have_text(@riemann.name)
    expect(page).not_to have_link(href: person_path(@riemann))

    visit search_results_path(query: "bern")
    expect(page).not_to have_text(@curie.name)
    expect(page).not_to have_link(href: person_path(@curie))
  end

  it "lists people whose full name or last name starts with the query before other found people" do
    visit search_results_path(query: "rie")
    expect(page.body.index(@riemann.name)).to be < page.body.index(@curie.name)

    visit search_results_path(query: "ma")
    expect(page.body.index(@curie.name)).to be < page.body.index(@riemann.name)
  end
end
