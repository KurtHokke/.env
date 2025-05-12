cmake_minimum_required(VERSION 4.0.0)

project(test VERSION 1.0 LANGUAGES C) 

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(SOURCES
    src/main.c
)
add_executable(test ${SOURCES})

find_package(PkgConfig REQUIRED)
pkg_check_modules(jansson REQUIRED IMPORTED_TARGET jansson>=2.14.1)
target_link_libraries(test PUBLIC PkgConfig::jansson)

#set(OPT OFF)
#if(OPT)
#elseif(OPT)
#else()
#endif()
