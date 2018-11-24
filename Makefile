
.PHONY: example clean

CC=gcc-7
CPP_FLAGS:=-std=c++17 -Wall -Wextra -pedantic -Werror -fmax-errors=2
LINK_FLAGS:=-lm -lstdc++

example: main.o
	$(CC) $(CPP_FLAGS) main.o $(LINK_FLAGS) -o example

test: test_main.o ieee-packing_tests.o
	$(CC) $(CPP_FLAGS) -DCATCH_BUILD test_main.o ieee-packing_tests.o $(LINK_FLAGS) -o test

test_main.o: test_main.cpp
	$(CC) -x c++ $(CPP_FLAGS) -c test_main.cpp -o test_main.o

main.o: main.cpp
	$(CC) -x c++ $(CPP_FLAGS) -c main.cpp -o main.o

ieee-packing_tests.o: main.cpp
	$(CC) -x c++ $(CPP_FLAGS) -c ieee-packing_tests.cpp -o ieee-packing_tests.o

clean:
	rm -rf *.o
	rm -f test
	rm -f example


