CC=g++

all: plotter clean

plotter: plotter.o plotterDriver.o
	$(CC) plotter.o plotterDriver.o -o plotter

plotter.o: plotter.cpp
	$(CC) -c -std=c++11 plotter.cpp

clean:
	rm plotter.o && rm plotter
