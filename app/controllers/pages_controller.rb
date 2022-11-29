class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home, :about, :faq]

  def home
  end

  def about
  end

  def faq
  end
end
