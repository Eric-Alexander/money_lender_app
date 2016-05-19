class LendersController < ApplicationController
  def show
  end
  def create
    @lender = Lender.create(lender_params)
    if @lender.save
      flash[:success] = "Welcome, Lender!"
    else
      flash[:errors]
      redirect_to :back
    end
  end
  private
  def lender_params
    params.require(:lender).permit(:first_name, :last_name, :email, :password, :money)
  end
end
