require 'rails_helper'

RSpec.describe "rooms/show", type: :view do
  before do
    @building = create :building
    @user = create :user
    @room = assign(:room, Room.create!(
                            name: "Name",
                            floor: "Floor",
                            room_type: "Room Type",
                            user: @user,
                            building: @building
                          ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Floor/)
    expect(rendered).to match(/Room Type/)
  end
end
