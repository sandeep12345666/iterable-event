module IterableEventPerformService
  class UpdateEventService < IterableEventPerformService::MainService
    def event(users, event)
      user_ids = users
      begin
        ActiveRecord::Base.transaction do
          user_ids.each do |user_id|
            user = find_user(user_id)
            next unless user
            unless event.users.include?(user)
              track_event_for_user(user, event.title, event.id)
              event.users << user
            end
          end
        end
        event
      rescue StandardError => e
        Rails.logger.error("Error while adding users to event")
        false
      end
    end

    private

    def find_user(user_id)
      User.find_by(id: user_id)
    end

    def track_event_for_user(user, title, event_id)
      body_response = {
            "email": user.email,
            "userId": user.id,
            "id": event_id,
            "eventName": title
          }
      respond = mock_response(:post, '/api/events/track', body_response)
      unless respond == 'success'
        raise StandardError, "Failed to find event for user: #{user.id}"
      end
    end
  end
end


  