class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]


  def new
    @book = Book.new
  end

  def create
    @new_book = Book.new(book_params)
    @new_book.user_id = current_user.id
    if @new_book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@new_book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def index
    @user = current_user
    @new_book = Book.new
    @books = Book.all
  end

  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @current_user = current_user
    @user = @book.user
    @book_comment = BookComment.new
  end

  def edit
    @edit_book = Book.find(params[:id])
    if @edit_book.user != current_user
      @user = current_user
      @new_book = Book.new
      @books = Book.all
      render :index
    end
  end

  def update
    @edit_book = Book.find(params[:id])

    if @edit_book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@edit_book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def is_matching_login_user
    @book = Book.find(params[:id])
    user_id = @book.user.id
    login_user_id = current_user.id
    if (user_id != login_user_id )
      redirect_to books_path
    end
  end
end
