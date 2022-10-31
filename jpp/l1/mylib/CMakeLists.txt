cmake_minimum_required(VERSION 3.0.0)
project(mylib VERSION 0.1.0)

include(CTest)
enable_testing()

include_directories(include)

add_library("${PROJECT_NAME}_iterative"
  src/my_math.c
)

# shared version needed for python wrapper
add_library("${PROJECT_NAME}_iterative_shared"
  SHARED
  src/my_math.c
)
add_custom_target(
  COPY ALL
  cp "lib${PROJECT_NAME}_iterative_shared.so" "../../python/mylib/"
  DEPENDS "${PROJECT_NAME}_iterative_shared"
)

add_library("${PROJECT_NAME}_recursive"
  src/my_math.c
)
target_compile_definitions("${PROJECT_NAME}_recursive" PRIVATE
RECURSIVE_IMPLEMENTATION
)

add_custom_target(
  ADA_FILES ALL "gprbuild" "default.gpr"
  WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/src"
)

add_library("${PROJECT_NAME}_ada_wrapper"
  src/my_math.c
)
target_compile_definitions("${PROJECT_NAME}_ada_wrapper"
  PRIVATE ADA_WRAPPER
)
target_link_libraries("${PROJECT_NAME}_ada_wrapper"
  ${CMAKE_CURRENT_SOURCE_DIR}/src/lib/libmylibada.so
)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})

set_property(TARGET "${PROJECT_NAME}_recursive" PROPERTY C_STANDARD 99)
set_property(TARGET "${PROJECT_NAME}_iterative" PROPERTY C_STANDARD 99)
set_property(TARGET "${PROJECT_NAME}_ada_wrapper" PROPERTY C_STANDARD 99)

include(CPack)
