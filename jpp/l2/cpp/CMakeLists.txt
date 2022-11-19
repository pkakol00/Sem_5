cmake_minimum_required(VERSION 3.0.0)
project(FiniteField VERSION 0.1.0)

include(CTest)
enable_testing()

add_executable(${PROJECT_NAME} 
  src/main.cpp 
  src/finite_field.h 
  src/finite_field.cpp
)
set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 17)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
