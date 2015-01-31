class InvitationsController < ApplicationController
  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new(invitation_params)
    if @invitation.valid?
      @invitation.enqueue
      redirect_to enqueued_invitations_url
    else
      render :new
    end
  end

  def enqueued
  end

  private
  def invitation_params
    params.require(:invitation).permit(:email)
  end
end
