class AppParametersController < ApplicationController

  def account_period
    if request.put?
      AppConstant.account_period params[:app_constant][:date_].to_date
    end
    @account_period = AppConstant.find_by_name "account_period"
  end  

end
