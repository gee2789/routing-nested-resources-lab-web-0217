class SongsController < ApplicationController

  def index
    if params[:artist_id]
      if artist_id_exist
        @songs = artist_id_exist.songs
      else
        flash[:alert] = "Artist not found"
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    #redirect to artist song when artist song not found
    if song_id_exist
      @song = song_id_exist
    else
      flash[:alert] = "Song not found"
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

  def artist_id_exist
    Artist.find_by(id: params[:artist_id])
  end

  def song_id_exist
    Song.find_by(id: params[:id])
  end

end
