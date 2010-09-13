 #!/usr/bin/ruby
require 'fileutils'

MEDIAPATH = '/media/'
DOWNLOADSDIR = '/home/david/downloads/complete/TV'
puts 'The Script is Running'

#tv directories are split alphabetically
def tvDirectory(show)
  if show =~ /^[A-Ha-h]/
    return 'tv'
  elsif show =~ /^[I-Pi-p]/
    return 'tv2'
  else
    return 'tv3'
  end
end

#checks if show and season folders exists, if they don't create them
def foldersExist?(show, season)
  if !File.directory?(MEDIAPATH + tvDirectory(show))
    puts 'directory did not exist, creating it'
    puts MEDIAPATH + tvDirectory(show)
    Dir.mkdir(MEDIAPATH + tvDirectory(show))
  end

  if !File.directory?(MEDIAPATH + tvDirectory(show) + '/' + show)
    puts 'directory did not exist, creating it'
    puts MEDIAPATH + tvDirectory(show) + '/' + show
    Dir.mkdir(MEDIAPATH + tvDirectory(show) + '/' + show)
  end

  if !File.directory?(MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season)
    puts 'directory did not exist, creating it'
    puts MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season
    Dir.mkdir(MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season)
  end
end

Dir.chdir(DOWNLOADSDIR)
dir = Dir.glob("*.{avi,mkv}")

#pull show information out of filename and move file to show folder
dir.each do |filename|
  if filename =~ /([0-9]+)x([0-9]*)/ 
    season = $1
    episode = $2
    show = filename.gsub(/ -.*/, '')
    #I don't want 'the' in the folder names
    if show =~ /^The/
      show = show.gsub(/^The /, '')
      show += ", The"
    end

    foldersExist?(show, season)
    puts "Moving #{filename} to #{MEDIAPATH}#{tvDirectory(show)}/#{show}/Season #{season}/#{filename}"
    FileUtils.mv(DOWNLOADSDIR + '/' + filename, MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season + '/' + filename)
  end
end
