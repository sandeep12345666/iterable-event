require 'rails_helper'

RSpec.describe IterableEventPerformService::UpdateEventService, type: :service do
  let(:service) { described_class.new }

  describe '#event' do
    let(:user_ids) { [1, 2, 3] }
    let(:event) { double('Event', title: 'Test Event', id: 1, users: []) }
    let(:users) do
      [
        instance_double('User', id: 1, email: 'user1@example.com'),
        instance_double('User', id: 2, email: 'user2@example.com'),
        instance_double('User', id: 3, email: 'user3@example.com')
      ]
    end

    before do
      allow(User).to receive(:find_by).and_return(nil)
      user_ids.each do |user_id|
        allow(User).to receive(:find_by).with(id: user_id).and_return(users[user_id - 1])
      end
    end

    context 'when all users are found' do
      before do
        user_ids.each do |user_id|
          allow(service).to receive(:track_event_for_user)
        end
      end

      it 'tracks events for each user and adds them to the event' do
        expect(service).to receive(:track_event_for_user).exactly(3).times
        updated_event = service.event(user_ids, event)
        expect(updated_event.users).to eq(users)
      end

      it 'returns the event' do
        updated_event = service.event(user_ids, event)
        expect(updated_event).to eq(event)
      end
    end
  end
end
