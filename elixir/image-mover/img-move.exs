require Enum
require String
require File

# create images/ if not exists
# list all files
# filter .jpg, .gif, .bmp and .png files
# move filtered images to images/


File.mkdir_p!("images/")

File.ls!()
  |> Enum.filter(fn filename -> String.match?(filename, ~r{.*\.(jpg|gif|bmp|png)$}) end)
  |> Enum.each(fn filename -> File.rename!(filename, "images/" <> filename) end)
