require_dependency 'reading/application_controller'
require 'epub/parser'

module Reading
  class BooksController < ApplicationController
    before_action :must_admin!, only: [:destroy, :admin]
    def index
      @books = Book.order(vote: :desc).page params[:page]
    end

    def admin
      @books = Book.order(updated_at: :desc).page params[:page]
    end

    def destroy
      bk = Book.find(params[:id])
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
