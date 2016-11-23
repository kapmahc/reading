require_dependency 'reading/application_controller'
require 'epub/parser'

module Reading
  class BooksController < ApplicationController

    def index
      @books = Book.order(vote: :desc).page params[:page]
    end

    def admin
      authorize Book.new
      @books = Book.order(updated_at: :desc).page params[:page]
      render layout: 'dashboard'
    end

    def destroy
      bk = Book.find(params[:id])
      authorize bk
      bk.destroy

      redirect_to admin_books_path
    end


    def show
      @book = Book.find(params[:id])
      bk = EPUB::Parser.parse @book.file
      bk.each_content do |pg|
        if pg.id == 'toc'
          redirect_to page_path(id:@book.id, name:pg.entry_name)
          return
        end
      end
      head :not_found
    end
  end
end
