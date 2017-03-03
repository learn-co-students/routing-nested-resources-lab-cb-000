class SongsController < ApplicationController




  def index
    if p = params[:artist_id]
      (@songs = find_artist(p).try :songs) || alert_redirect(1)
    else
      @songs = Song.all
    end
  end

  def show
    if p = params[:artist_id]      
      if a = find_artist(p)
        (@song = a.songs.find_by(id: params[:id])) || alert_redirect(2, a)
      else
        redirect_to songs_path
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

    def song_params
      params.require(:song).permit(:title, :artist_name)
    end
    
    def find_artist(artist_id)
      Artist.find_by(id: params[:artist_id])
    end

    def alert_redirect(number, obj = nil)
      case number
      when 1; redirect_to artists_path, alert: "Artist not found!"
      when 2; redirect_to artist_songs_path(obj), alert: "Song not found!"
      end
    end

end

