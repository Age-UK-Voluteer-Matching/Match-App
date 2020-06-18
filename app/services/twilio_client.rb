class TwilioClient

  def send_text(elderly, volunteer)
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "You have received a notification to connect with #{elderly.name}. Please contact her within 48hrs on #{elderly.telephone}. To see her full profile please visit age-uk-volunteer-matching.herokuapp.com",
        to: volunteer.telephone,
        from: ENV["FROM"])

    puts message.sid
  end
end
