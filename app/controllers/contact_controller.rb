class ContactController < ApplicationController
  protect_from_forgery with: :null_session

  def create
    name = params[:name].to_s.strip
    email = params[:email].to_s.strip
    message = params[:message].to_s.strip

    if name.blank? || email.blank? || message.blank?
      return respond_to do |format|
        format.html { redirect_to root_path(error: 1) }
        format.json { render json: { ok: false, error: "Missing fields" }, status: :unprocessable_entity }
      end
    end

    ContactMailer.contact_email(name, email, message).deliver_now

    respond_to do |format|
      format.html { redirect_to root_path(sent: 1), allow_other_host: false }
      format.json { render json: { ok: true } }
    end
  rescue => e
    Rails.logger.error("Contact form error: #{e.message}")
    respond_to do |format|
      format.html { redirect_to root_path(error: 1) }
      format.json { render json: { ok: false, error: "Mail delivery failed" }, status: :internal_server_error }
    end
  end
end
