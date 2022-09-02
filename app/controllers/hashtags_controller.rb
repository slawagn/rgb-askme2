class HashtagsController < ApplicationController
  def show
    @hashtag = Hashtag.find_by(tag: params[:tag])
  end
end
