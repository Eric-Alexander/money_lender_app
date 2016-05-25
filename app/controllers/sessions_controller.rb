class SessionsController < ApplicationController
  def login
  	render "new"
  end

  def register
  	@lender = Lender.new
  	@borrower = Borrower.new
  	render "register"
  end

  def create
  	user = Lender.find_by email: params[:email]
  	if user
  		if user.authenticate(params[:password])
  			session[:user_type] = "lender"
        log_in user
  			redirect_to "/lender/#{user.id}"
  		else
  			flash[:errors] = ["Incorrect password"]
  			redirect_to :back
  		end
  	else
  		user = Borrower.find_by email: params[:email]
  		if user
  			if user.authenticate(params[:password])
  				session[:user_type] = "borrower"
          log_in user
  				redirect_to "/borrowers/#{user.id}"
  			else
  				flash[:errors] = ["Incorrect password"]
  				redirect_to :back
  			end
  		else
  			flash[:errors] = ["E-mail address not found"]
  			redirect_to :back
  		end
  	end
  end

  def destroy
  	session[:user_id] = nil
  	session[:user_type] = nil
  	redirect_to root_path
  end
end
