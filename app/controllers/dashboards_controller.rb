class DashboardsController < ApplicationController
  before_filter :require_user, :only => [ :show ]

  def show
    @user = @current_user
    @month_show = params[:id]
  end

end
