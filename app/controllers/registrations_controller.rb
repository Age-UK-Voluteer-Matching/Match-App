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
    @user_interests = current_user.interests.ids
    @possible_matches = User.includes(:interests)
      .where(interests: { id: @user_interests })
      .where.not(id: current_user.id)
      .where.not(volunteer: current_user.volunteer)

      @possible_matches.each do |user|
      newints = user.interests.ids
      newints += @user_interests
      @results = { 1 => [2040],
        1002 => [2002, 2004, 2000, 2006]
       }
      shared_interests = []
      newints.each { |interest|
        if newints.count(interest) > 1
          shared_interests.push(interest)
        end
      }
      @results[user.id] = shared_interests.uniq
    end
      new = @results.sort_by{ |key, value| value.length}
  end

  private

  def user_params
    params.require(:user).permit(:name, :telephone, :location, :bio, :image)
  end

end
