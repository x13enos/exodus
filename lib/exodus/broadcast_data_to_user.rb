class Exodus::BroadcastDataToUser
  attr_accessor :channel, :data, :method
  def initialize(params)
    self.channel = params[:channel]
    self.data = params[:data]
    self.method = params[:method]
  end

  def perform
    send_request_to_user
  end

  private

  def send_request_to_user
    RestClient::Request.execute(
      :method => method,
      :url => Settings.faye.url,
      :payload => { :message => request_message.to_json },
      :timeout => 2,
      :open_timeout => 2
    )
  end

  def request_message
    { :channel => channel, :data => data }
  end
end
