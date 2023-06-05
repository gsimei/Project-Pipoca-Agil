class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :email_confirmation ]

  def home
  end

  def email_confirmation
  end
end
