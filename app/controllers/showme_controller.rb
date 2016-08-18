class ShowmeController < ApplicationController
  def list

  end

  def listdetail

  end

  def nikowrite

  end

  def nikoupdate

  end

  def nikodelete

  end

end

=begin class SoundcloudController < ApplicationController
  def listaa
  client = SoundCloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"])
  # get 10 hottest tracks
  tracks = client.get('/tracks', :limit => 10, :order => 'hotness')
  track_url = 'http://soundcloud.com/forss/flickermood'
  embed_info = client.get('/oembed', :url => track_url)
  @abc = embed_info['url']
  end
  def connect
    # create client object with app credentials
  client = Soundcloud.new(:client_id => ENV["SOUNDCLOUD_CLIENT_ID"],
                          :client_secret => ENV["SOUNDCLOUD_CLIENT_SECRET"],
                          :redirect_uri => "http://localhost:3000/showme/list",
                          :response_type => 'code')


  # redirect user to authorize URL
  redirect_to client.authorize_url(:grant_type => 'authorization_code', :scope => 'non-expiring', :display => 'popup')
  end

  def connected
  end

  def destroy
  end
end

=end
