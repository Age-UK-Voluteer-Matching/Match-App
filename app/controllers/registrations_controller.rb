class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def after_sign_up_path_for(resource)
    "/add_info"
  end

  def add_info
    @user = current_user
  end

  def add_image
    @user = current_user
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        if user_params[:image] == nil
          format.html { redirect_to add_userinterests_path }
        else
          format.html { redirect_to show_path }
        end
      else
        format.html { render :add_info }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    # grabs matches based on the interests of the current user
    @user_interests = current_user.interests.ids
    @fetched_matches = User.includes(:interests)
      .where(interests: { id: @user_interests })
      .where.not(id: current_user.id)
      .where.not(volunteer: current_user.volunteer)

      # hash to store the results of the support routine
      @results = {}
      # support routine to calculate and order users based on who has the most matched interests
      @fetched_matches.each do |user|
        other_user_interests = user.interests.ids
        other_user_interests += @user_interests
        shared_interests = []
        other_user_interests.each { |interest|
          if other_user_interests.count(interest) > 1
            shared_interests.push(interest)
          end
        }
      @results[user] = shared_interests.uniq
    end
      ordered_users = @results.sort_by{ |key, value| -value.length}.to_h
      # return array of users in order of most matched interests
      @possible_matches = ordered_users.keys
  end

  private

  def user_params
    params.require(:user).permit(:name, :telephone, :location, :bio, :image)
  end

end
