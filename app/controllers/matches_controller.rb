class MatchesController < ApplicationController
  def index
    @matches = Match.where("volunteer_id = #{current_user.id}")
  end

  def create
    @volunteer = User.find(params[:match])
    @match = current_user.older_relationships.create(volunteer_id: @volunteer.id)
    redirect_to confirmation_path
    session[:volunteer_id] = @volunteer.id
    send_text(current_user, @volunteer)
  end

  def confirmation
    @profile = session[:volunteer_id]
    @current_profile = User.find(@profile)
  end

  private

  def send_text(elderly, volunteer)
    account_sid = ENV["ACCOUNT_SID"]
    auth_token = ENV["AUTH_TOKEN"]

    @client = Twilio::REST::Client.new account_sid, auth_token
    message = @client.messages.create(
        body: "You have received a notification to connect with #{elderly.name}. Please contact them within 48hrs on #{elderly.telephone}. To see their full profile please visit https://volunteer-match-app.herokuapp.com/",
        to: volunteer.telephone,
        from: ENV["FROM"])

    puts message.sid
  end
end
