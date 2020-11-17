class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)

    #if a user with the given email both exists in the database and has the given password
    if user && user.authenticate(params[:session][:password])

      # allow users to log in only if they are activated
      if user.activated?
        forwarding_url = session[:forwarding_url]
        # reset the session immediately before logging in so that the attacker’s desired id gets cleared and a freshly created id ends up in the session hash
        reset_session
        #check remember me
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        # log in the user and redirect to the user's show page.
        log_in user
        redirect_to forwarding_url || user
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to root_url
      end

    else
      # create error msg
      #
      #
      # flash.now: specifically designed for displaying flash messages on rendered pages
      flash.now[:danger] = 'Invalid email/password combination' #
      render 'new'
    end

  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
