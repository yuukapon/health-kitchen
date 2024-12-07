class Admin::GenresController < ApplicationController
  layout 'admin'  
  before_action :authenticate_admin! 
  before_action :set_genre, only: [:edit, :update, :destroy] 
  
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to admin_genres_path, notice: "ジャンルを登録しました"
    else
      @genres = Genre.all
      render :index
    end
  end

  def update
    if @genre.update(genre_params)
      redirect_to admin_genres_path, notice: "ジャンルを更新しました"
    else
      render :edit
    end
  end
  
  def destroy
    @genre.destroy
    redirect_to admin_genres_path, notice: "ジャンルを削除しました。"    
  end

  private
  
  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name)
  end
end