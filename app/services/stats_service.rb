require "bunny"

class StatsService
  def call
    visit_data = subsribed_visit_data

    if visit_data
      decoded_data = ActiveSupport::JSON.decode(visit_data)
      Visit.create!(decoded_data) 
    end
  end

  private

  QUEUE_NAME = "dev-queue"

  def subsribed_visit_data
    begin
      connection = Bunny.new
      connection.start

      channel = connection.create_channel

      queue = channel.queue QUEUE_NAME
    
      delivery_info, properties, payload = queue.pop

      sleep 1

      connection.close

      return payload
    rescue Exception => e
      puts e
      
      return nil
    end
  end
end