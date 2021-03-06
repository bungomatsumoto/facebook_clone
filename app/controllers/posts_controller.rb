class PostsController < ApplicationController
  before_action :get_id_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    # has_manyのpostsを使い、current_userのpostをnewする
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "投稿を作成しました"
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿を編集しました"
    else
      render :edit
    end
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private

  def post_params
    params.require(:post).permit(:content, :image, :image_cache)
  end

  def get_id_post
    @post = Post.find(params[:id])
  end
end
