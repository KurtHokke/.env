cmake_minimum_required(VERSION 4.0.0)

project(main VERSION 1.0 LANGUAGES C) 

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_FLAGS "-O0 -Wall -Wextra -Wpedantic")

set(option(DEBUG OFF))
set(option(TEST OFF))


if(TEST)
    set(SOURCES
        src/test.c
        src/utils.h
        src/utils.c
    )
else()
    set(SOURCES
        src/main.c
        src/utils.h
        src/utils.c
        src/curling.h
        src/curling.c
        src/jsson.c
    )
endif()

add_executable(main ${SOURCES})

find_package(PkgConfig REQUIRED)
pkg_check_modules(libcurl REQUIRED IMPORTED_TARGET libcurl>=8.13.0)
pkg_check_modules(jansson REQUIRED IMPORTED_TARGET jansson>=2.14.1)

target_link_libraries(main PUBLIC PkgConfig::libcurl PkgConfig::jansson)
#target_link_libraries(main PUBLIC PkgConfig::libcurl)
#target_link_libraries(main PUBLIC PkgConfig::jansson)



if(DEBUG)
    message("Running with -DDEBUG=ON")
    target_compile_definitions(main PRIVATE DEBUG)
endif()

#set(OPT OFF)
#if(OPT)
#elseif(OPT)
#else()
#endif()
