require 'epub/parser'

namespace :reading do
  desc 'scan epub books'
  task scan: :environment do
    Dir.glob(Rails.root.join('tmp', 'books', '**', '*.epub')).each do |fn|
      puts "Find book #{fn}"

      book = EPUB::Parser.parse(fn)
      meta = book.metadata

      if Reading::Book.where(file: fn).count == 0
        bk = Reading::Book.new file: fn,
                             title: meta.title,
                             author: meta.creators.first.content,
                             lang: meta.language.content,
                             version: book.package.version,
                             publisher: meta.publishers.first.content,
                             subject: meta.subjects.empty? ? '-' : meta.subjects.first.content,
                             published_at: meta.date.content
        bk.author = '-' if bk.author.empty?
        bk.save
        unless bk.valid?
          raise bk.errors.inspect
        end
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

