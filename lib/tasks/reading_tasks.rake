require 'epub/parser'

namespace :reading do
  desc 'scan epub books'
  task scan: :environment do
    Dir.glob(Rails.root.join('tmp', 'books', '**', '*.epub')).each do |fn|
      puts "Find book #{fn}"

      book = EPUB::Parser.parse(fn)
      meta = book.metadata

      bk = Reading::Book.where(file: fn).first
      unless bk
        bk = Reading::Book.new file: fn
      end

      bk.title= meta.title
      bk.author= meta.creators.first.content
      bk.lang= meta.language.content
      bk.version= book.package.version
      bk.publisher= meta.publishers.first.content
      bk.subject= meta.subjects.empty? ? '-' : meta.subjects.first.content
      bk.published_at= meta.date.content
      bk.author = '-' if bk.author.empty?

      bk.save
      unless bk.valid?
        raise bk.errors.inspect
      end

    end
  end

  namespace :download do
    desc '下载妙云集'
    task :yinshun do
      root = Rails.root.join('tmp', 'books', 'yinshun')
      FileUtils.mkdir_p root

      def download(root, id)
        name = "#{root}/#{id}.epub"
        unless File.exists?(name)
          puts `wget -O #{name} "http://www.yinshun.org.tw/epub's%20web/epub/y#{id}.epub"`
        end
      end

      1.upto(24) { |i| download root, ('%02d' % i) }
      42.upto(44) { |i| download root, i }

    end
  end
end

