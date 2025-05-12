cmake_minimum_required(VERSION 4.0.0)

project(test VERSION 1.0 LANGUAGES C) 

set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)

set(SOURCES
    src/main.c
)
add_executable(test ${SOURCES})

#find_package(PkgConfig REQUIRED)
#pkg_check_modules(libcurl REQUIRED IMPORTED_TARGET libcurl>=8.13.0)
#target_link_libraries(test PUBLIC PkgConfig::libcurl)

#set(OPT OFF)
#if(OPT)
#elseif(OPT)
#else()
#endif()
