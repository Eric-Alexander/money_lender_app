class BorrowersController < ApplicationController
  def show
  end
  def create
    @borrower = Borrower.create(borrower_params)
    if @borrower.save
      flash[:success] = "Welcome, Borrower!"
      redirect_to borrower_path
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
