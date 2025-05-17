cmake_minimum_required(VERSION 4.0.0)

set(option(DEBUG OFF))
set(option(TEST OFF))

if(TEST)
    project(test VERSION 1.0 LANGUAGES C)
else()
    project(main VERSION 1.0 LANGUAGES C) 
endif()


set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_BUILD_TYPE Debug)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(CMAKE_C_FLAGS "-O0 -Wall -Wextra -Wpedantic")


find_package(PkgConfig REQUIRED)


if(TEST)
    set(SOURCES
        test/test.c
        src/utils.h
    )
    set(EXE test)

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
    target_link_libraries(main PUBLIC PkgConfig::libcurl PkgConfig::jansson)
    
endif()

message("\nSetting SOURCES:\n${SOURCES}\n\nSetting EXE:\n${EXE}\n")

add_executable(${EXE} ${SOURCES})

if(DEBUG)
    message("Running with -DDEBUG=ON")
    target_compile_definitions(main PRIVATE DEBUG)
endif()

#target_link_libraries(main PUBLIC PkgConfig::libcurl)
#target_link_libraries(main PUBLIC PkgConfig::jansson)