require "mkmf"

$CFLAGS << " -DNOSEGV" if ENV["FIX"]

header_dirs =
[
  ::RbConfig::CONFIG["includedir"],
  "/usr/local/include",
  "/usr/local/proj/include",
  "/usr/local/proj4/include",
  "/opt/local/include",
  "/opt/proj/include",
  "/opt/proj4/include",
  "/opt/include",
  "/opt/homebrew/include",
  "/Library/Frameworks/PROJ.framework/unix/include",
  "/usr/include"
]
lib_dirs =
[
  ::RbConfig::CONFIG["libdir"],
  "/usr/local/lib",
  "/usr/local/lib64",
  "/usr/local/proj/lib",
  "/usr/local/proj4/lib",
  "/opt/local/lib",
  "/opt/proj/lib",
  "/opt/proj4/lib",
  "/opt/lib",
  "/opt/homebrew/lib",
  "/Library/Frameworks/PROJ.framework/unix/lib",
  "/usr/lib",
  "/usr/lib64"
]
header_dirs.delete_if { |path| !::File.directory?(path) }
lib_dirs.delete_if { |path| !::File.directory?(path) }

header_dirs, lib_dirs = dir_config("proj", header_dirs, lib_dirs)

$libs << " -lproj"

create_makefile "repro"
