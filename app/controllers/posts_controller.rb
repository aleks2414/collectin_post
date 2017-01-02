class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :filter_admin!, only: [:new, :edit]
  impressionist :actions=>[:show,:index]

  def search
    if params[:search].present?
      @posts = Post.search(params[:search])
    else
      @posts = Post.all
      @posts = @posts.page params[:page]
    end

  end

  def mexico
    @posts = Post.where(category: "México").order("created_at desc")
    @posts = @posts.page params[:page]
  end

  def favorites
    @posts = current_user.find_up_voted_items
  end

  def economia_y_finanzas
    @posts = Post.where(category: "Economía y Finanzas").order("created_at desc")
    @posts = @posts.page params[:page]
  end

  def deportes
    # @poste = Post.where(category: "Deportes").order("created_at asc").limit(4).offset(4)
    # @posta = Post.where(category: "Deportes").order("created_at asc").limit(4)
    @posts = Post.where(category: "Deportes").order("created_at desc")
    @posts = @posts.page params[:page]
  end

  def espectaculos_y_moda
    @posts = Post.where(category: "Espectáculos y Moda").order("created_at desc")
    @posts = @posts.page params[:page]
  end

  # GET /posts
  # GET /posts.json
def index
  if params[:tag]
    @posts = Post.tagged_with(params[:tag])
  else
    @posts = Post.order("created_at desc")
  end
    @posts = @posts.page params[:page]

end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def filter_admin!
 authenticate_user!
 redirect_to root_path, alert: "No tienes acceso" unless current_user.admin?
end


def upvote 
  @post = Post.find(params[:id])
  @post.liked_by current_user
  redirect_to :back
end  

def downvote
  @post = Post.find(params[:id])
  @post.downvote_from current_user
  redirect_to :back
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.friendly.find(params[:id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :description, :date, :category, :paper, :user_id, :favorite, :url, :photo, :tag_list, :slug)
    end
end
