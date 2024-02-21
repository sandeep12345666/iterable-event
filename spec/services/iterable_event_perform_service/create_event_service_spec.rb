require 'rails_helper'

module IterableEventPerformService
  describe CreateEventService do
    describe '#user_event' do
      let(:user) { instance_double(User, id: 1, email: 'test@example.com') }
      let(:name) { 'Test Event' }
      let(:service) { described_class.new }

      context 'when the request is successful' do
        before do
          allow(service).to receive(:mock_response).and_return('success')
        end

        it 'creates a new IterableEvent' do
          expect {
            service.user_event(user, name)
          }.to change(IterableEvent, :count).by(1)
        end

        it 'returns the created event' do
          event = service.user_event(user, name)
          expect(event).to be_a(IterableEvent)
          expect(event.user_id).to eq(user.id)
          expect(event.title).to eq(name)
        end
      end

      context 'when the request fails' do
        before do
          allow(service).to receive(:mock_response).and_return('failure')
        end

        it 'does not create a new IterableEvent' do
          expect {
            service.user_event(user, name)
          }.not_to change(IterableEvent, :count)
        end

        it 'returns false' do
          expect(service.user_event(user, name)).to be_falsey
        end
      end
    end
  end
end
