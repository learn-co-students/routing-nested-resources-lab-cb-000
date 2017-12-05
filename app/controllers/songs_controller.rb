class SongsController < ApplicationController

  def index
    # In the songs#index action, if the artist can't be found,
    # redirect to the index of artists, and set a flash[:alert] of "Artist not found."
    # @artist = Artist.find(params[:artist_id])
    @artist = Artist.find_by(id: params[:artist_id])
    if params[:artist_id] && @artist
      #&& Artist.find(params[:artist_id])
      # if there is a stated artist
      @songs = Artist.find(params[:artist_id]).songs #then return the songs for this artist
    elsif params[:artist_id] # otherwise if there is a stated artist
      redirect_to artists_path # redirect to the path of the artist
    else
      @songs = Song.all #otherwise, there is no artist.  Redirect to show all songs.
      # In the songs#index action, if the artist can't be found,
      # redirect to the index of artists, and set a flash[:alert] of "Artist not found."
      flash[:notice] = "Artist not found."
      # redirect_to songs_path
    end
  end

  def show
    @song = Song.find_by(params[:id])
    @artist = Artist.find_by(params[:artist_id])
    if @song == nil
      binding.pry
      flash[:notice] = "Song not found."
      redirect_to artist_songs_path(params[:artist_id])
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
end
