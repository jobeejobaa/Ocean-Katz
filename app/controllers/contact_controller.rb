class ContactController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    name = params[:name]
    email = params[:email]
    message = params[:message]

    ContactMailer.contact_email(name, email, message).deliver_now

    respond_to do |format|
      format.html { redirect_to root_path(sent: 1), allow_other_host: false }
      format.json { render json: { ok: true } }
    end
  end
end
