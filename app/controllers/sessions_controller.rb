class SessionsController < ApplicationController
  def login
  end

  def register
    @lender = Lender.new
    @borrower = Borrower.new
  end
end
