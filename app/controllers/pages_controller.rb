class PagesController < ApplicationController
  def coming_soon
    @feature = params[:feature].presence || "This page"
  end
end
