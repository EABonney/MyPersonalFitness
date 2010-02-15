class WorkoutsController < ApplicationController
  before_filter :require_user, :only => [ :show ]
  def show
    @month_show = params[:id]
  end
  
end
