class BooksController < ApplicationController
  before_action :set_book, only: %i[show edit update destroy]

  # GET /books
  def index
    @books = current_user.books
    if params[:tags].present?
      tags = params[:tags].split(",").map(&:strip)
      @books = @books.where("tags ILIKE ANY (array[?])", tags.map { |tag| "%#{tag}%" })
    end
  end

  # GET /books/:id
  def show; end

  # GET /books/new
  def new
    @book = current_user.books.build
  end

  # POST /books
  def create
    @book = current_user.books.build(book_params)
    if @book.save
      redirect_to books_path, notice: "Book added successfully."
    else
      render :new
    end
  end

  # GET /books/:id/edit
  def edit; end

  # PATCH/PUT /books/:id
  def update
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "Book updated successfully."
    else
      render :edit
    end
  end

  # DELETE /books/:id
  def destroy
    @book.destroy
    redirect_to books_path, notice: "Book deleted successfully."
  end

  private

  # Find book by ID and ensure it belongs to the current user for sensitive actions
  def set_book
    @book = current_user.books.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to books_path, alert: "Book not found."
  end

  # Strong parameters for book creation and updates
  def book_params
    params.require(:book).permit(:name, :author, :tags, :about, :image, :shelf_id)
  end
end
