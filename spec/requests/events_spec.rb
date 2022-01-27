require 'rails_helper'
require 'ice_cube'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/events", type: :request do

  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    Event.new(name: "BA Mathematik III Übung",
              description: "Teaching mathematics",
              room: create(:room),
              d_start: "2021-10-25 13:15:00",
              d_end: "2021-10-25 14:45:00",
              recurring: IceCube::Rule.weekly.day(:monday).to_yaml
            ).attributes
  end

  let(:invalid_attributes) do
    Event.new.attributes
  end

  describe "GET /index" do
    it "renders a successful response" do
      Event.create! valid_attributes
      get events_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      event = Event.create! valid_attributes
      get event_url(event)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_event_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      event = Event.create! valid_attributes
      get edit_event_url(event)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Event" do
        expect do
          post events_url, params: { event: valid_attributes }
        end.to change(Event, :count).by(1)
      end

      it "redirects to the created event" do
        post events_url, params: { event: valid_attributes }
        expect(response).to redirect_to(event_url(Event.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Event" do
        expect do
          post events_url, params: { event: invalid_attributes }
        end.to change(Event, :count).by(0)
      end

      it "renders an unprocessable_entity response (i.e. to display the 'new' template)" do
        post events_url, params: { event: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "POST /import" do
    context "without a file parameter" do
      before do
        post import_events_path
      end

      it "redirects to the index page" do
        expect(response).to redirect_to(events_url)
      end
      
      it "alerts that a ICS file has to be chosen first" do
        expect(flash[:alert]).to eq("Please choose an ICS file to import")
      end
    end

    context "with a non ICS file parameter" do
      before do
        non_ics_file = Rack::Test::UploadedFile.new("#{Rails.root}/spec/routing/events_routing_spec.rb")
        post import_events_path, params: { file: non_ics_file }
      end

      it "redirects to the index page" do
        expect(response).to redirect_to(events_url)
      end

      it "alerts that only ICS files can be imported" do
        expect(flash[:alert]).to eq("Only ICS files can be imported")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_event) do
        Event.new(name: "MA Combinatorial Optimization / Friedrich",
                  description: "MA Combinatorial Optimization by Friedrich",
                  room: create(:room),
                  d_start: "2021-10-28 09:00:00",
                  d_end: "2021-10-28 10:30:00",
                  recurring: IceCube::Rule.weekly.day(:thursday).to_yaml)
      end
      let(:new_attributes) do
        new_event.attributes
      end

      it "updates the requested event" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(event.name).to eq(new_event.name)
        expect(event.description).to eq(new_event.description)
        expect(event.room).to eq(new_event.room)
        expect(event.d_start).to eq(new_event.d_start)
        expect(event.d_end).to eq(new_event.d_end)
        expect(event.rule).to eq(new_event.rule)
      end

      it "redirects to the event" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: new_attributes }
        event.reload
        expect(response).to redirect_to(event_url(event))
      end
    end

    context "with invalid parameters" do
      it "renders an unprocessable_entity response (i.e. to display the 'edit' template)" do
        event = Event.create! valid_attributes
        patch event_url(event), params: { event: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested event" do
      event = Event.create! valid_attributes
      expect do
        delete event_url(event)
      end.to change(Event, :count).by(-1)
    end

    it "redirects to the events list" do
      event = Event.create! valid_attributes
      delete event_url(event)
      expect(response).to redirect_to(events_url)
    end
  end
end
