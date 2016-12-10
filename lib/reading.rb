require 'reading/engine'

module Reading
  def self.dashboard(user)
    links = [
        {label: 'reading.notes.index.title', href: 'notes_path'},
        {label: 'reading.favorites.index.title', href: 'favorites_path'},
    ]

    if user.is_admin?
      links << {label: 'reading.books.index.title', href: 'books_path'}
    end

    {
        label: 'reading.dashboard.title',
        links: links,
    }
  end

  def self.sitemap
    app = Reading::Engine.routes.url_helpers
    links = []
    Setting.languages.each do |l|

      links << {url: app.hot_notes_path(locale:l)}
      links << {url: app.latest_notes_path(locale:l)}

      links << {url: app.hot_books_path(locale:l)}
      links += Book.select(:id, :updated_at).map do |i|
        {url:book_path(i), lastmod:i.updated_at}
      end

      links << {url: app.root_path(locale:l)}
    end
    links
  end
end
