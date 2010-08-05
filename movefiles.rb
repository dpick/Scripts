require 'fileutils'

MEDIAPATH = '/media/'
DOWNLOADSDIR = '~/downloads/complete/TV'


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
    Dir.mkdir(MEDIAPATH + tvDirectory(show))
  end

  if !File.directory?(MEDIAPATH + tvDirectory(show) + '/' + show)
    puts 'directory did not exist, creating it'
    Dir.mkdir(MEDIAPATH + tvDirectory(show) + '/' + show)
  end

  if !File.directory?(MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season)
    puts 'directory did not exist, creating it'
    Dir.mkdir(MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season)
  end
end

dir = Dir.open(DOWNLOADSDIR) 

dir.each do |filename|
  if filename =~ /([0-9]+)x([0-9]*)/ 
    season = $1
    episode = $2
    show = filename.gsub(/ -.*/, '')
    if show =~ /^The/
      show = show.gsub(/^The /, '')
    end

    foldersExist?(show, season)

    FileUtils.mv(filename, MEDIAPATH + tvDirectory(show) + '/' + show + '/Season ' + season + '/' + filename)
  end
end
