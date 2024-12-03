require 'fastimage'
require 'image_size'
require 'image_processing/vips'
require 'dimensions'


# Function to get dimensions using FastImage
def dimensions_fastimage(file)
  FastImage.size(file)
rescue => e
  puts "FastImage error: #{e.message}"
  nil
end

# Function to get dimensions using ImageSize
def dimensions_image_size(file)
  size = ImageSize.path(file)
  [size.width, size.height]
rescue => e
  puts "ImageSize error: #{e.message}"
  nil
end

# Function to get dimensions using ImageProcessing with libvips
def dimensions_image_processing(file)
  vips_image = Vips::Image.new_from_file(file)
  [vips_image.width, vips_image.height]
rescue => e
  puts "ImageProcessing error: #{e.message}"
  nil
end

# Function to get dimensions using Dimensions
def dimensions_dimensions(file)
  Dimensions.dimensions(file)
rescue => e
  puts "Dimensions error: #{e.message}"
  nil
end


# Main program
if ARGV.empty?
  puts "Usage: ruby image-sizes.rb <image_file>"
  exit
end

image_file = ARGV[0]

puts "Comparing image dimensions for: #{image_file}"
puts "FastImage: #{dimensions_fastimage(image_file)}"
puts "ImageSize: #{dimensions_image_size(image_file)}"
puts "Dimensions: #{dimensions_dimensions(image_file)}"
puts "ImageProcessing (libvips): #{dimensions_image_processing(image_file)}"
