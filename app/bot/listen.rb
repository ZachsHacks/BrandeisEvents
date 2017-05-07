require "facebook/messenger"
include Facebook::Messenger
Facebook::Messenger::Subscriptions.subscribe(access_token: ENV["ACCESS_TOKEN_Facebook"])
# message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
# message.sender      # => { 'id' => '1008372609250235' }
# message.sent_at     # => 2016-04-22 21:30:36 +0200
# message.text        # => 'Hello, bot!'
future_events = Event.where('start < ?', Time.now).reverse
@top_events = future_events.sort_by(&:rsvps_count).last(10).reverse.map { |e| [e.name, e.start, e.location] }


Bot.on :message do |message|
  Bot.deliver({
    recipient: message.sender,
    message: {
      text: "The top upcoming event is #{@top_events[0].name}. It can be found at http://CampusNow.herokuapp.com/events/#{@top_events[0].id}. We also recomend going to #{@top_events[1].name}. It can be found at http://CampusNow.herokuapp.com/events/#{@top_events[1].id}. "
    }
  }, access_token: ENV["ACCESS_TOKEN_Facebook"])
end
