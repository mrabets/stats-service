require 'bunny'

class StatsService
  def call
    visit_data = subsribed_visit_data

    return unless visit_data

    decoded_data = ActiveSupport::JSON.decode(visit_data)
    Visit.create!(decoded_data)
  end

  private

  QUEUE_NAME = 'dev-queue'

  def subsribed_visit_data
    connection = Bunny.new
    connection.start

    channel = connection.create_channel

    queue = channel.queue QUEUE_NAME

    delivery_info, properties, payload = queue.pop

    sleep 1

    connection.close

    payload
  rescue Bunny::Exception => e
    Rails.logger.debug e

    nil
  end
end
