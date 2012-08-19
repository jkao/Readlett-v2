class FeedbackController < ApplicationController

  def create
    @feedback = Feedback.new
    @feedback.message = params[:message]
    @feedback.user = current_user

    if @feedback.save
      render :status => 200, :nothing => true
    else
      render :status => :bad_request, :nothing => true
    end
  end

end
