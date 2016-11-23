require_dependency 'reading/application_controller'

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
  end
end
