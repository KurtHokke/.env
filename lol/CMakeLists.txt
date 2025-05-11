cmake_minimum_required(VERSION 4.0.1)

project(lol)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(SOURCES 
    src/main.c
)

add_executable(lol ${SOURCES})

find_package(PkgConfig REQUIRED)
pkg_check_modules(libcurl REQUIRED IMPORTED_TARGET libcurl>=8.13.0)
pkg_check_modules(libcjson REQUIRED IMPORTED_TARGET libcjson>=1.7.18)
pkg_check_modules(libcjson_utils REQUIRED IMPORTED_TARGET libcjson_utils>=1.7.18)
target_link_libraries(lol PUBLIC PkgConfig::libcurl PkgConfig::libcjson)

#message(STATUS "Found CURL: ${CURL_VERSION_STRING}")