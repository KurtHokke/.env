cmake_minimum_required(VERSION 4.0.0)

project(main VERSION 1.0 LANGUAGES C)

option(DEBUG OFF)
option(TESTING OFF)

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_FLAGS "-O0 -Wall -Wextra -Wpedantic -std=c11")


find_package(PkgConfig REQUIRED)


if(TESTING STREQUAL "ON")
    set(SOURCES
        src/test.c
        src/utils.h
    )
    set(EXE testing)

else()
    set(SOURCES
        src/main.c
        src/utils.h
        src/utils.c
        src/curling.h
        src/curling.c
        src/jsson.c
    )
    set(EXE main)
    pkg_check_modules(libcurl REQUIRED IMPORTED_TARGET libcurl>=8.13.0)
    pkg_check_modules(jansson REQUIRED IMPORTED_TARGET jansson>=2.14.1)
    
endif()

message("\nSetting SOURCES:\n${SOURCES}\n\nSetting EXE:\n${EXE}\n")

add_executable(${EXE} ${SOURCES})

if(TESTING STREQUAL "OFF")
    target_link_libraries(${EXE} PUBLIC PkgConfig::libcurl PkgConfig::jansson)
endif()

if(DEBUG STREQUAL "ON" OR TESTING STREQUAL "ON")
    message("Running with -DDEBUG=ON")
    target_compile_definitions(${EXE} PRIVATE DEBUG)
endif()

#target_link_libraries(main PUBLIC PkgConfig::libcurl)
#target_link_libraries(main PUBLIC PkgConfig::jansson)