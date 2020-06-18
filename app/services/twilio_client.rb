class TwilioClient

  def send_text
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "You have received a notification to connect with Ethel. Please contact her within 48hrs on 0778889999. To see her full profile please visit age-uk-volunteer-matching.herokuapp.com",
        to: ENV["TO"],
        from: ENV["FROM"])

    puts message.sid
  end
end
