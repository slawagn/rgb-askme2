class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by!(tag: params[:tag])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path
  end
end
