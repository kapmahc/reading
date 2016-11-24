require 'reading/engine'

module Reading
  def Reading.dashboard(user)
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
end
