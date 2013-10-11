def remove_path(path)
  FileUtils.rm(path, force: true) if File.exists?(path)
  FileUtils.rm_r(path, force: true) if Dir.exists?(path)
end
