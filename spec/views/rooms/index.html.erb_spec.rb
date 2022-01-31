require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  before do
    @building = create :building
    @people = [(create :person)]
    @rooms = Room.create([{ name: "Lecture hall 1",
                            floor: 0,
                            room_type: "lecture-hall",
                            location_latitude: 1.5,
                            location_longitude: 3.5 },
                          { name: "H-2.57",
                            floor: 2,
                            room_type: "seminar-room",
                            location_latitude: 4.5,
                            location_longitude: 5 }]) do |u|
      u.people = @people
      u.building = @building
    end
  end

  it "renders a list of rooms" do
    render
    expect(rendered).to have_text("Seminar rooms")
    expect(rendered).to have_text("H-2.57")
    expect(rendered).to have_text("Lecture halls")
    expect(rendered).to have_text("Lecture hall 1")
    expect(rendered).to have_text("Pool rooms")
    expect(rendered).to have_text("Conference rooms")
  end
end
