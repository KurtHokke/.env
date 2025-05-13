cmake_minimum_required(VERSION 4.0.0)

project(cUnit VERSION 1.0 LANGUAGES C) 

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(SOURCES
    main.c
)
add_executable(cUnit ${SOURCES})

find_package(PkgConfig REQUIRED)
pkg_check_modules(cunit REQUIRED IMPORTED_TARGET cunit>=1)
pkg_check_modules(ncurses REQUIRED IMPORTED_TARGET ncurses>=1)
target_link_libraries(cUnit PUBLIC PkgConfig::cunit PkgConfig::ncurses)

#set(OPT OFF)
#if(OPT)
#elseif(OPT)
#else()
#endif()
