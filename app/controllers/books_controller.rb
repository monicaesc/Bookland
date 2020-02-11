class BooksController <ApplicationController
  def index
    @books = Book.all
  end

  def new
      @book = Book.new
  end

  def show
      @book = Book.find(params[:id])
  end

  def create
      @book = Book.new(books_params)
      @book.user_id = current_user.id
      @book.save
      redirect_to book_path(@book)
  end

  def edit
    @book = Book.find(params[:id])
    if current_user != @book.user
      redirect_to "/"
      flash[:alert] = "Unauthorized request"
    end
  end

  def update
      book = Book.find(params[:id])
      if current_user == book.user
        book.update(books_params)
        redirect_to book
        flash[:notice] = "Update succesful!"
        book.save
      else
        redirect_back(fallback_location: root_path)
        flash[:alert] = "Not authorized to update book"
      end

end

    private
      def books_params
          params.require(:book).permit(:name, :author, :year, :genre, :description)
      end
end
