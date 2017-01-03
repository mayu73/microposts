class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @title = "Micropost Feeds"
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).order(created_at: :desc)
    end
  end
end

