require_dependency 'reading/application_controller'

module Reading
  class PagesController < ApplicationController
    def show
      @book = Book.find(params[:id])
      bk = EPUB::Parser.parse @book.file

      name = "#{params[:name]}.#{params[:format]}"
      bk.each_content do |pg|
        if pg.entry_name == name
          case pg.media_type
          when 'application/xhtml+xml'
            doc =Nokogiri::XML(pg.read)
            @title = "#{doc.css('head title').first.content}-#{@book.title}-#{@book.author}"
            @body = doc.css('body').first.inner_html
          else
            send_data pg.read, type: pg.media_type, disposition: 'inline'
          end
          return
        end
      end
      head :not_found
    end
  end
end
