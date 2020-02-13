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
      bookInfoResponse = Request.get_json("/books/v1/volumes", @book.name) #I copied the path from the url in the googleapis
      # puts bookInfoResponse
      bookVolumnInfo = bookInfoResponse[0]["items"][0]["volumeInfo"]
      @book.cover_url = bookVolumnInfo["imageLinks"]["smallThumbnail"]
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
        bookInfoResponse = Request.get_json("/books/v1/volumes", book.name)
        puts bookInfoResponse
        # linea 34 dice el api de google retorna toda la info de el libro con base al nombre
        bookVolumnInfo = bookInfoResponse[0]["items"][0]["volumeInfo"]
        book.cover_url = bookVolumnInfo["imageLinks"]["smallThumbnail"]
        # un arreglo de libros, [0] significa el primer elemento
        book.update(books_params)
        redirect_to book
        flash[:notice] = "Update succesful!"
        book.save
      else
        redirect_back(fallback_location: root_path)
        flash[:alert] = "Not authorized to update book"
      end

   def overview
   end

   def favorite
     @books = Book.where("favorite_books = ?",true)
   end

end

    private
      def books_params
          params.require(:book).permit(:name, :author, :year, :genre, :description, :favorite_books, :cover_url)
      end
end
