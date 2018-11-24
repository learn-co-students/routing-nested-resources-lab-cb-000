class SongsController < ApplicationController

  def index

    if params[:artist_id] # a value here means a user navigated to artist_songs_path
      @songs = Artist.find(params[:artist_id]).songs
    else
      @songs = Song.all
    end
  
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "Artist not found"
    redirect_to artists_path

  # could probably, alternately, use a rescue block within the if statement itself
  # "rescue ActiveRecord::..." won't work within the if satement
  
  end


  def show

    if params[:artist_id]
      @song = Song.find_by!(artist_id: params[:artist_id], id: params[:id])
    else
      @song = Song.find(params[:id])
    end

  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Song not found"
    redirect_to artist_songs_path
    
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

