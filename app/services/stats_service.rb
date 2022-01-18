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

  def subsribed_visit_data
    connection = Bunny.new
    connection.start

    channel = connection.create_channel

    queue = channel.queue "dev-queue"

    delivery_info, properties, payload = queue.pop

    sleep 1

    connection.close

    return payload
  end
end