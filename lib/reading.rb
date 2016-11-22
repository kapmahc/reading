require 'reading/engine'

module Reading
  def Reading.dashboard(user)
    {
        label: 'reading.home.dashboard.title',
        links: [
            {label: '111', href: 'root_path'},
            {label: '222', href: 'root_path'},
            {label: '333', href: 'root_path'},
        ]
    }
  end
end
