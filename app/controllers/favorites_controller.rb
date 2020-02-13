class FavoritesController < ApplicationController
   before_action :find_book
  def create

    # puts "--->" + @book.name (just to see what the console prints)

    value = @book.favorite_books
    @book.favorite_books = !value
    @book.save
    redirect_to book_path(@book)
  end

  private
  def find_book
    @book = Book.find(params[:book_id])
  end
end
