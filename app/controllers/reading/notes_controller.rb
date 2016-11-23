require_dependency 'reading/application_controller'

module Reading
  class NotesController < ApplicationController
    before_action :authenticate_user!, except: [:hot, :latest]

    def new
      @note = Note.new reading_book_id: params[:book_id]
      authorize @note
    end

    def create
      @note = Note.new params.require(:note).permit(:body, :reading_book_id)
      authorize @note
      @note.user = current_user

      if @note.save
        redirect_to latest_notes_path
      else
        render 'new'
      end
    end


    def edit
      @note = Note.find(params[:id])
      authorize @note
    end

    def update
      @note = Note.find(params[:id])
      authorize @note
      if @note.update(params.require(:note).permit(:body))
        redirect_to latest_notes_path
      else
        render 'edit'
      end

    end

    def destroy
      n = Note.find(params[:id])
      authorize @note

      n.destroy
      redirect_to notes_path
    end


    def index
      if current_user.is_admin?
        @notes = Note.order(updated_at: :desc).page params[:page]
      else
        @notes = Note.where(user_id: current_user.id).order(updated_at: :desc).page params[:page]
      end
      render layout: 'dashboard'
    end

    def hot
      @notes = Note.order(updated_at: :desc).page params[:page]
      @title = t '.title'
      render 'list'
    end

    def latest
      @notes = Note.order(vote: :desc).page params[:page]
      @title = t '.title'
      render 'list'
    end
  end
end
