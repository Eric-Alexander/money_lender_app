class LendersController < ApplicationController
  def show
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.all
  end
  def create
    @lender = Lender.create(lender_params)
    if @lender.save
      session[:user_type] = "lender"
      session[:user_id] = @lender.id
      flash[:success] = "Welcome, Lender!"
      redirect_to "/lenders/#{@lender.id}"
    else
      flash[:errors] = @lender.errors.full_messages
      redirect_to :back
    end
  end
  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end
end
