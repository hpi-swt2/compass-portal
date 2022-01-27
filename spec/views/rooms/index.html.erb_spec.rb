require 'rails_helper'

RSpec.describe "rooms/index", type: :view do
  before do
    @building = create :building
    @people = [(create :person)]
    @rooms = Room.create([{ name: "Lecture hall 1", floor: 0, room_type: "lecture-hall" },
                          { name: "H-2.57", floor: 2, room_type: "seminar-room" }]) do |u|
      u.people = @people
      u.building = @building
    end
    @events = Event.create([{ name: "Hörsaal1 Event",
                              recurring: IceCube::Rule.daily.to_yaml,
                              d_start: 1.hour.from_now,
                              d_end: 2.hours.from_now,
                              room: @rooms[0] },
                            { name: "H.257 Event",
                              recurring: IceCube::Rule.daily.to_yaml,
                              d_start: 30.minutes.ago,
                              d_end: 30.minutes.from_now,
                              room: @rooms[1] }])
  end

  it "renders a list of rooms" do
    render
    expect(rendered).to have_text("Seminar rooms")
    expect(rendered).to have_text("H-2.57")
    expect(rendered).to have_text("Lecture halls")
    expect(rendered).to have_text("Lecture hall 1")
    expect(rendered).to have_text("Pool rooms")
    expect(rendered).to have_text("Conference rooms")
    expect(rendered).to have_text("free")
    expect(rendered).to have_text("occupied")
  end
end
