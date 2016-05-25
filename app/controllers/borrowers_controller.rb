class BorrowersController < ApplicationController
  def show
    @borrower = Borrower.find params[:id]
    @loans = History.where(borrower: @borrower).joins(:lender).select("lenders.first_name, lenders.last_name, lenders.email, amount")
  end
  def create
    @borrower = Borrower.create(borrower_params)
    @borrower.money_raised = 0
    if @borrower.save
      session[:user_type] = "borrower"
      log_in @borrower
      flash[:success] = "Welcome, Borrower!"
      redirect_to "/borrowers/#{@borrower.id}"
    else
      flash[:errors] = @borrower.errors.full_messages
      redirect_to :back
    end
  end
  private
  def borrower_params
    params.require(:borrower).permit(:first_name, :last_name, :email, :password, :money_purpose, :money_needed, :description)
  end
end
