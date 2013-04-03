namespace :js do

  desc 'Build JavaScript from CoffeeScript source code'
  task :build do
    command = [
      './node_modules/coffee-script/bin/coffee',
      '--compile',
      '--output ./lib',
      './src/*.coffee'
    ]
    system command.join(' ')
  end

  desc 'Use UglifyJS to compress JavaScript'
  task :uglify do
    require 'uglifier'
    Dir['./lib/*.js']
      .select { |f| not f.match(/min\.js$/) }
      .each do |file_name|
        source        = File.read(file_name)
        compressed    = Uglifier.compile(source, copyright: false)
        min_file_name = file_name.gsub(/\.js$/, '.min.js')

        File.open(min_file_name, 'w') do |f|
          f.write(compressed)
        end

        uglify_rate  = compressed.length.to_f / source.length
        gzipped_size = `cat #{min_file_name} | gzip -9f | wc -c`.to_i
        gzip_rate    = gzipped_size.to_f / source.length

        puts "# #{file_name}.js"
        puts "Original size: #{source.length}b or #{(source.length.to_f / 1024).round(2)}kb"
        puts "Uglified size: #{compressed.length}b (#{(uglify_rate * 100).round}% from original size)"
        puts "GZipped size:  #{gzipped_size}b or #{(gzipped_size.to_f / 1024).round(2)}kb (#{(gzip_rate * 100).round}% from original size)"
    end
  end
end

