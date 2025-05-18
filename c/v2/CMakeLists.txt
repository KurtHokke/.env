cmake_minimum_required(VERSION 4.0.0)

project(main VERSION 1.0 LANGUAGES C)

option(DEBUG OFF)
option(TESTING OFF)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_FLAGS "-O0 -Wall -Wextra -Wpedantic")


find_package(PkgConfig REQUIRED)


if(TESTING STREQUAL "ON")
    set(SOURCES
        test.c
        #test.h
        #test1.c
    )
    set(EXE testing)
    pkg_check_modules(ncursesw REQUIRED IMPORTED_TARGET ncursesw>=6.5.20240427)
else()
    set(SOURCES
        src/main.c
        src/utils.h
        src/sighandle.c
        src/curling.c
    )
    set(EXE main)
    pkg_check_modules(libcurl REQUIRED IMPORTED_TARGET libcurl>=8.13.0)
    pkg_check_modules(jansson REQUIRED IMPORTED_TARGET jansson>=2.14.1)
    #pkg_check_modules(ncurses REQUIRED IMPORTED_TARGET ncurses>=6.5.20240427)
    
endif()

message("\nSetting SOURCES:\n${SOURCES}\n\nSetting EXE:\n${EXE}\n")

add_executable(${EXE} ${SOURCES})

if(TESTING STREQUAL "OFF")
    target_link_libraries(${EXE} PUBLIC PkgConfig::libcurl PkgConfig::jansson) #PkgConfig::ncurses)
else()
    target_link_libraries(${EXE} PUBLIC PkgConfig::ncursesw)
endif()

if(DEBUG STREQUAL "ON" OR TESTING STREQUAL "ON")
    target_compile_definitions(${EXE} PRIVATE DEBUG)
endif()

#target_link_libraries(main PUBLIC PkgConfig::libcurl)
#target_link_libraries(main PUBLIC PkgConfig::jansson)