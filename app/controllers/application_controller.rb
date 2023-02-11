# frozen_string_literal: true

require 'application_responder'

class ApplicationController < ActionController::Base
  before_action :authenticate_user!, unless: :devise_controller?
  include ApplicationResponder

  private

  def current_company
    @current_company ||= current_user.company if user_signed_in?
  end
  helper_method :current_company
end
