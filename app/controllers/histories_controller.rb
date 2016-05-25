class HistoriesController < ApplicationController
  def create
    if current_user && session[:user_type] == "lender"
      @lender = current_user
      @borrower = Borrower.find(params[:borrower_id])
      @amount = params[:amount].to_i
      if @amount > @lender.money
        flash[:errors] = ["This amount exceeds the money you have available to lend."]
        redirect_to "/lenders/#{@lender.id}"
      elsif @amount <= 0
        flash[:errors] = ["You cannot lend $0.00 or you have insuffienct funds to lend this amount."]
        redirect_to "/lender/#{@lender.id}"
      else
        History.create(borrower: @borrower, lender: @lender, amount: @amount)
        @lender.money -= @amount
        @lender.save
        @borrower.money_raised += @amount
        @borrower.save

        redirect_to "/lender/#{@lender.id}"
      end

    elsif !current_user
      flash[:errors] = ["You must be logged in to complete a transaction."]
      redirect_to login_path
    elsif session[:user_type] == "borrower"
      flash[:errors] = ["If you're asking for money you certainly cannot lend money!"]
      redirect_to "/borowers/#{@borrower.id}"
    else
      flash[:errors] = ["Uh oh. Something went wrong. Please, try again."]
      redirect_to :back
    end
  end
end
