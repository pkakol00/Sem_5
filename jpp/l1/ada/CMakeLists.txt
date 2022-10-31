project(MY_MATH)
cmake_minimum_required(VERSION 3.0.0)

CMAKE_C_STANDARD(99)

add_library(MY_MATH my_math.h my_math.c c_my_math.h c_my_math.c)