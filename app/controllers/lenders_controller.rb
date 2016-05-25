class LendersController < ApplicationController
  def show
    @lender = Lender.find(params[:id])
    @borrowers = Borrower.where("money_needed > money_raised").order(money_needed: :desc)
    @loans_given = History.where(lender: @lender).joins(:borrower).select("borrowers.first_name, borrowers.last_name, borrowers.money_needed, borrowers.money_raised, borrowers.description, borrowers.money_purpose, amount")
  end
  def create
    @lender = Lender.create(lender_params)
    if @lender.save
      session[:user_type] = "lender"
      log_in @lender
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
