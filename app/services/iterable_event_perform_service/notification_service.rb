module IterableEventPerformService
  class NotificationService < IterableEventPerformService::MainService
    def notification(user, name)
      begin     
        body = {
          "campaignId": 0,
          "recipientEmail": user.email,
          "recipientUserId": user.id,
          "sendAt": Time.now,
          "allowRepeatMarketingSends": true
          }
        response = mock_response(:post, '/api/email/target', body)
        if response == 'success'
          SendNotificationMailer.notification(user.email, name).deliver_now
          return true
        else
          raise StandardError, "not able to sent email notification"
        end
      rescue StandardError => e
        Rails.logger.error("Error sending email notification: #{e.message}")
        return false
      end
    end
  end
end