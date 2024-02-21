require 'rails_helper'

RSpec.describe IterableEventPerformService::NotificationService do
  describe '#notification' do
    let(:notification_service) { described_class.new }
    let(:user) { User.create(email: 'demo@demo.com', password: 'password') }
    let(:name) { 'Test Notification' }
    it 'rescues from errors and returns false' do
      allow(notification_service).to receive(:mock_response).and_raise(StandardError)

      expect(Rails.logger).to receive(:error).with(/Error sending email notification/)

      expect(notification_service.notification(user, name)).to be_falsey
    end
  end
end
