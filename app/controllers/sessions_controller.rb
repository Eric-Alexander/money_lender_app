class SessionsController < ApplicationController
  def new

  end
  def create
    puts "___________________________________"
    @session = Lender.find_by(email: params[:email])
    puts @session
    if @session
      if @session.authenticate(params[:password])
        session[:user_id] = user.id
        session[:user_type] = "lender"
        flash[:success] = "Welcome Back!"
        puts "+++++++++++++++++++++++++++++++"
        puts lender_path
        redirect_to lender_path
      else
        flash[:errors] = ["Incorrect password for email"]
        redirect_to :back
      end
    else
      user = Borrower.find_by email: params[:email]
      if user
        if user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:user_type] = "borrower"
          flash[:success] = "Welcome Back!"
          redirect_to borrower_path
        else
          flash[:errors] = ["Incorrect password for email"]
          redirect_to :back
        end
      else
        flash[:errors] = "User not found."
        flash[:errors] = "User not found"
        puts "|||||||||||||||||||||||||||||||||"
        destroy

      end
    end
  end

  def register
    @lender = Lender.new
    @borrower = Borrower.new
  end
  def destroy
    session[:user_id] = nil
    session[:user_type] = nil
    flash[:success] = "Successful Logout."
    redirect_to '/'
  end
end
