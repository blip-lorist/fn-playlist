class SongsController < ApplicationController
  require 'httparty'


  ARTIST_URI = "https://itunes.apple.com/search?"


  def index
  end

  def artist_redirect
    if params[:artist].present?
      redirect_to artist_path(params[:artist])
    else
      redirect_to root_path
    end
  end

  def artist
    @artist = params[:artist]
    response = HTTParty.get(ARTIST_URI + "term=#{@artist}&entity=song")
    @songs = JSON.parse(response)["results"]

    @explicit_tracks =[]
    @songs.each do |song|
      if song["trackExplicitness"] == "explicit"
        @explicit_tracks << song["trackCensoredName"]
      end
    end

    @explicit_tracks

  end
end
