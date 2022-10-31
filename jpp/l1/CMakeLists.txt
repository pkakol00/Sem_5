cmake_minimum_required(VERSION 3.0.0)
project(DualLibrary VERSION 0.1.0)

include(CTest)
enable_testing()

add_subdirectory(mylib)

# Variable controlling used library version
# Set to {iterative, recursive, ada_wrapper}
set(LIB_VERSION ada_wrapper)
add_executable(${PROJECT_NAME} main.c)
add_dependencies(${PROJECT_NAME} ADA_FILES)

target_include_directories(${PROJECT_NAME} PUBLIC "${CMAKE_SOURCE_DIR}/mylib/include/")
target_link_directories(${PROJECT_NAME} PUBLIC "${CMAKE_SOURCE_DIR}/mylib/bin/")

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
set_property(TARGET ${PROJECT_NAME} PROPERTY C_STANDARD 99)

message("Using lib version: " ${LIB_VERSION})

if (${LIB_VERSION} STREQUAL iterative)
  target_link_libraries(${PROJECT_NAME} PRIVATE "mylib_iterative")
elseif(${LIB_VERSION} STREQUAL ada_wrapper)
  # ada lib is dynamically linked so it needs to be linked also here
  target_link_libraries(${PROJECT_NAME} 
    "mylib_ada_wrapper"
    ${CMAKE_CURRENT_SOURCE_DIR}/mylib/src/lib/libmylibada.so
  )
else()
  target_link_libraries(${PROJECT_NAME} PRIVATE "mylib_recursive")
endif()

include(CPack)
