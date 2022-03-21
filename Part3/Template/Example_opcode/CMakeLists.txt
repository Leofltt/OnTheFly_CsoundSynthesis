make_plugin(example_opcode example.cpp)
target_include_directories(example_opcode PRIVATE
${CSOUND_INCLUDE_DIRS})

target_link_libraries(example_opcode ${clang_libs})
target_compile_options(example_opcode PRIVATE "-std=c++17")