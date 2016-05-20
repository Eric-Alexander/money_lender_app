class SessionsController < ApplicationController
  def new




  end
  def create
    puts "___________________________________"
    user = Lender.find_by(email: params["session"][:email].downcase)
    puts user
    if user
      if user.authenticate(params[:session][:password])
        log_in user
        flash[:success] = "Welcome Back!"
        puts "+++++++++++++++++++++++++++++++"

        redirect_to "/lenders/#{user.id}"
      else
        flash[:errors] = ["Incorrect password for email"]
        redirect_to :back
      end
    else
      user = Borrower.find_by(email: params["session"][:email].downcase)
      if user
        if user.authenticate(params[:password])
          log_in user
          redirect_to "/borrowers/#{user.id}"
        else
          flash[:errors] = ["Incorrect password for email"]
          redirect_to :back
        end
      else
        flash[:errors] = "User not found."
        flash[:errors] = "User NEVER found"
        puts "|||||||||||||||||||||||||||||||||"
        redirect_to :back

      end
    end
  end

  def register
    @lender = Lender.new
    @borrower = Borrower.new
  end
  def destroy
    log_out
    flash[:success] = "Successful Logout."
    redirect_to root_url
  end
end
