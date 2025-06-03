cmake_minimum_required(VERSION 3.10)
project(fnames C)

# Find LuaJIT
find_package(PkgConfig REQUIRED)
pkg_check_modules(LUAJIT REQUIRED luajit)

# Create shared library
add_library(fnames SHARED fnames.c)

# Include LuaJIT headers
target_include_directories(fnames PRIVATE ${LUAJIT_INCLUDE_DIRS})

# Link against LuaJIT (optional, only if needed for symbols)
target_link_libraries(fnames PRIVATE ${LUAJIT_LIBRARIES})

# Set output name to mylib.so (no lib prefix)
set_target_properties(fnames PROPERTIES
    PREFIX ""
    OUTPUT_NAME "fnames"
)

# Ensure position-independent code
set_target_properties(fnames PROPERTIES POSITION_INDEPENDENT_CODE ON)

target_compile_options(fnames PRIVATE -std=c99 -Wall -Werror)

install(TARGETS fnames DESTINATION /home/arcno/.local/share/nvim/libso)
