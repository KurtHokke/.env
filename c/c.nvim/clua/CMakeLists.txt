cmake_minimum_required(VERSION 3.10)
project(fnames C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Find LuaJIT
find_package(PkgConfig REQUIRED)
pkg_check_modules(LUAJIT REQUIRED luajit>=2.1)
if(NOT LUAJIT_FOUND)
    message(FATAL_ERROR "LuaJIT 2.1 or higher is required")
endif()

# Create shared library
add_library(fnames SHARED fnames.c)

# Include LuaJIT headers
target_include_directories(fnames PRIVATE ${LUAJIT_INCLUDE_DIRS})

# Link against LuaJIT (optional, only if needed for symbols)
# target_link_libraries(fnames PRIVATE ${LUAJIT_LIBRARIES})

# Set output name to mylib.so (no lib prefix)
set_target_properties(fnames PROPERTIES
    PREFIX ""
    OUTPUT_NAME "fnames"
    SUFFIX ${CMAKE_SHARED_LIBRARY_SUFFIX}
)

# Ensure position-independent code
set_target_properties(fnames PROPERTIES POSITION_INDEPENDENT_CODE ON)

target_compile_options(fnames PRIVATE
  -std=c99 -Wall -Werror -O3 -flto -march=native)

target_link_options(fnames PRIVATE -flto)

if(UNIX)
    add_custom_command(TARGET fnames POST_BUILD
        COMMAND ${CMAKE_STRIP} $<TARGET_FILE:fnames>
        COMMENT "Stripping debug symbols from fnames.so")
endif()
# Configurable install path
set(NEOVIM_LIB_DIR
  "$ENV{HOME}/.local/share/nvim/libso" CACHE PATH
  "Neovim shared library install directory")

install(TARGETS fnames DESTINATION ${NEOVIM_LIB_DIR})

# install(TARGETS fnames DESTINATION /home/arcno/.local/share/nvim/libso)
