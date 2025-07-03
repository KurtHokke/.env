cmake_minimum_required(VERSION 3.10)
project(main C)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

add_executable(main main.c)


target_compile_options(main PRIVATE
  -Wall
  -Werror
  -std=c99 -O3 -flto -march=native)
