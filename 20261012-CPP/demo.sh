g++ --version | head -1
g++ -std=c++23 -O2 -o /tmp/hello hello.cpp && /tmp/hello
g++ -std=c++23 -O2 -o /tmp/raii raii.cpp && /tmp/raii
g++ -std=c++23 -O2 -o /tmp/template template.cpp && /tmp/template
