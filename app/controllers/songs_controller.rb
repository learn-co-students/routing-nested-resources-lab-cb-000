class SongsController < ApplicationController

  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  # def index
  #
  #   @artist = Artist.find_by(id: params[:artist_id])
  #   if params[:artist_id] && !!@artist
  #
  #     @songs = Artist.find(params[:artist_id]).songs #then return the songs for this artist
  #   elsif params[:artist_id] # otherwise if there is a stated artist
  #     redirect_to artists_path # redirect to the path of the artist
  #   else
  #     @songs = Song.all #otherwise, there is no artist.  Redirect to show all songs.
  #
  #     flash[:notice] = "Artist not found."
  #     # redirect_to songs_path
  #   end
  # end

  def show
      if params[:artist_id]
        @artist = Artist.find_by(id: params[:artist_id])
        if @artist.nil?
          binding.pry
          flash[:notice] = "Artist not found"
          redirect_to artists_path

        end

        @song = @artist.songs.find_by(id: params[:id])
        if @song.nil?
          redirect_to artist_songs_path(@artist), alert: "Song not found"
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

end
