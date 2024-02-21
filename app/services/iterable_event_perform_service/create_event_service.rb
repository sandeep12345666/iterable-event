module IterableEventPerformService
	class CreateEventService < IterableEventPerformService::MainService
		def user_event(user, name)
	    begin
        body_response = {
          "email": user.email,
          "userId": user.id,
          "id": 0,
          "eventName": name
        }
	      response = mock_response(:post, '/api/events/track', body_response)
	      if response == 'success'
	        event = IterableEvent.create(user_id: user.id, title: name)
	        return event
	      else
	        raise StandardError, "Failed to create event"
	      end
	    rescue StandardError => e
	      Rails.logger.error("Error creating event: #{e.message}")
	      return false
	    end
	  end
  end
end