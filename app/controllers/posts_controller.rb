class PostsController < ApplicationController

    before_action :authenticate_user!, except: [:index, :show]


    def index  
        @posts = Post.all.order(updated_at: :desc)
    end

    def show
        id = params[:id]
        @post = Post.find(id)
        @comment = Comment.new 
        @comments = @post.comments.order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params.require(:post).permit(:title, :body))
        if @post.save
            redirect_to post_path(@post)
          else
            render :new
          end
    end

    def destroy
        id = params[:id]
        @post = Post.find(id)
        @post.destroy
        redirect_to posts_path
    end

    def edit
        id = params[:id]
        @post = Post.find(id)
    end

    def update
        id = params[:id]
        @post = Post.find(id)
        if @post.update(params.require(:post).permit(:title, :body))
        redirect_to post_path(@post)
        else 
            render :edit
        end
    end
end
