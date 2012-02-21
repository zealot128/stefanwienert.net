namespace :optimize do
  @folder = "./source/images"
  @pngout = "./tasks/pngout"

  desc "optimize jpgs in #{@folder}"
  task :jpg do
    puts "optimizing jpgs..."
    puts %x[find #{@folder} -iname "*.jpg" -print0 | xargs -0 -n1 jpegoptim -m90 -q]
  end

  desc "optimize pngs in #{@folder}"
  task :png do
    puts "optimizing pngs..."
    puts %x[find #{@folder} -iname "*.png" -print0 | xargs -0 -n1 #{@pngout} -q]
  end
end
desc "optimize all jpg/pngs in the specified folder"
task :optimize => %w[optimize:jpg optimize:png]
