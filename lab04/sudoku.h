#ifndef FUNCTION_H_
#define FUNCTION_H_
#include <stdio.h>

#include <string.h>
#include <stdlib.h>


	char** createArray(int rows, int cols);
	void fillArray(char** myArray, int rows, int cols);
	void printArray(char** myArray, int rows, int cols);
	void deleteArray(char** myArray, int rows, int cols);
	char** makeMove(char** qesArray,char** ansArray);


#endif
