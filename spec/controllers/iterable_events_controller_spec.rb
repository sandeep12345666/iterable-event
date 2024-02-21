

require 'rails_helper'

RSpec.describe IterableEventsController, type: :controller do
  include Devise::Test::ControllerHelpers
  let(:user) { User.create(email: "demo@demo.com", password: "password") }
  let(:iterable_event) { IterableEvent.create(title: "event", user_id: user.id) }
  before { sign_in user }

  describe 'GET #index' do
    it 'assigns @iterable_events' do
      get :index
      expect(assigns(:iterable_events)).to_not be_nil
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #new' do
    it 'assigns a new iterable_event to @iterable_event' do
      get :new
      expect(assigns(:iterable_event)).to be_a_new(IterableEvent)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

 describe 'POST #create' do
  context 'with valid params' do
    let(:valid_params) { { type: 'A', title: 'Valid Title', user_id: user.id } }

    it 'creates a new event' do
      expect {
        post :create, params: { iterable_event: valid_params }
      }.to change { IterableEvent.count }.by(1)
    end

    it 'redirects to iterable_events_path with success flash message' do
      post :create, params: { iterable_event: valid_params }
      expect(response).to redirect_to(iterable_events_path)
      expect(flash[:success]).to eq("Event created successfully")
    end
  end

  context 'with invalid params' do
    let(:invalid_params) { { type: 'A', title: '', user_id: user.id } }

    it 'does not create a new event' do
      expect {
        post :create, params: { iterable_event: invalid_params }
      }.to_not change { IterableEvent.count }
    end
  end
end




  describe 'GET #show' do
    it 'assigns the requested event to @iterable_event' do
      get :show, params: { id: iterable_event.to_param }
      expect(assigns(:iterable_event)).to eq(iterable_event)
    end

    it 'renders the show template' do
      get :show, params: { id: iterable_event.to_param }
      expect(response).to render_template(:show)
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the requested event' do
        patch :update, params: { id: iterable_event.to_param, user_ids: [user.id] }
        iterable_event.reload
        expect(iterable_event.users).to include(user)
      end

      it 'redirects to the event' do
        patch :update, params: { id: iterable_event.to_param, user_ids: [user.id] }
        expect(response).to redirect_to(iterable_event_path(iterable_event))
      end
    end
  end
end
