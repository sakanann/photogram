class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  def index
    @pictures = Picture.all
  end

  def new
    @picture = Picture.new
  end

  def create
    @picture = current_user.pictures.build(picture_params)
    return render :new if params[:back]
    if @picture.save
      PictureMailer.picture_mail(@picture).deliver
      redirect_to pictures_path, notice: "投稿しました！"
    else
      render :new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
  end

  def edit
    @picture= Picture.find(params[:id])
  end

  def update
    @picture= Picture.find(params[:id])
		if @picture.update(picture_params)
      redirect_to pictures_path, notice: "ブログを編集しました！"
		else
      render :edit
		end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"ブログを削除しました！"
  end

  def confirm
    @picture = current_user.pictures.build(picture_params)
    render :new if @picture.invalid?
  end

  private
	
	def picture_params
    params.require(:picture).permit(:title, :content, :image, :image_cache)
	end
	
	# idをキーとして値を取得するメソッドを追加
	def set_picture
    @picture= Picture.find(params[:id])
	end
end