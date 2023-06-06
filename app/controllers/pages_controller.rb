class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :email_confirmation, :privacy ]

  def home
  end

  def email_confirmation
  end

  def privacy
  end
end
