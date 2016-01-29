#include <stdio.h> 
#include <stdlib.h>
#include <errno.h>
#include "sudoku.h"

 int main() 
 { 
	 char **ansArray;
	 char **qesArray;
     ansArray = createArray(9,9);
     qesArray = createArray(9,9);
     char filename[] = "suduko_puzzle.txt"; //文件名
     FILE *fp; 
     char StrLine[30];             //每行最大读取的字符数
//     char test[10]="abcdefg";
//     char test1 = test[5];
//     if(test[5] == 'f')
//     {
//     printf("true");
//     }
//     printf("%c",test1);
     if((fp = fopen(filename,"r")) == NULL) //判断文件是否存在及可读
     { 
         printf("error1!");
         return -1; 
     } 
     int count = 0;
    while(fgets(StrLine, sizeof(StrLine)-1, fp) != NULL){
    	int j = 0;
    	int i = 0;
    	for(i = 0; StrLine[i] != '\n';i++){
    		if (StrLine[i] == '*'){
    			ansArray[count][j] = StrLine[i+1];
    			qesArray[count][j] = StrLine[i+1];

    			j++;
    		}else if ((StrLine[i]<= 57 && StrLine[i] >=48 ) && (StrLine[i-1] != '*'))
    		{
    			ansArray[count][j] = StrLine[i];
    			qesArray[count][j] = '*';

    			j++;

    		}


    	}
       //printf("%s",StrLine);
    	count++;
       }
    //fillArray(ansArray, 9, 9);
       printArray(qesArray, 9,9);
       int win = 0;
       int a,b;
       while (win == 0){
    	   win = 1;
		   for(a=0;a<9;a++){
			   for(b=0;b<9;b++){
				   if(qesArray[a][b] == '*'){
					   win = 0;
				   }
			   }
		   }
		   makeMove(qesArray, ansArray);


       }

       printf("you win!");


     fclose(fp);                     //关闭文件
     return 0; 
 }
 char** makeMove(char** qesArray,char** ansArray){
	 int row;
	 int col;
	 char value;
	 printf("Enter row,col,value to solve a square, or -1 to exit: ");
	 scanf("%d",&row);
	 if(row == -1)
	 {
	 exit(1);
	 }
	 scanf("%d",&col);
	 getchar();
	 scanf("%c",&value);

	 if(ansArray[row-1][col-1] == value)
	        {
	     	   qesArray[row-1][col-1] = value;
	        }
	 printArray(qesArray, 9,9);
	 return qesArray;
 }
 char** createArray(int rows, int cols) {
   char **myArray;

   // Allocate a 1xROWS array to hold pointers to more arrays
   myArray = calloc(rows, sizeof(char *));
   if (myArray == NULL) {
     printf("FATAL ERROR: out of memory: %s\n", strerror(errno));
     exit(EXIT_FAILURE);
   }

   // Allocate each row in that column
   int i = 0;
   for (i = 0; i < rows; i++) {
     myArray[i] = calloc(cols, sizeof(char));

     if (myArray[i] == NULL) {
       printf("FATAL ERROR: out of memory: %s\n", strerror(errno));
       exit(EXIT_FAILURE);
     }
   }
   fillArray(myArray, rows,cols);

   return myArray;
 }

 void fillArray(char** myArray, int rows, int cols) {
   int count = 1;
   int i = 0;
   int j=0;

   for (i = 0; i < rows; i++) {
     for (j = 0; j < cols; j++) {
       myArray[i][j] =' ';
       count++;
     }
   }

   return;
 }

 void printArray(char** myArray, int rows, int cols) {
int i = 0;
int j=0;
printf("  1 2 3 4 5 6 7 8 9\n");
printf("  -------------------\n");
   for (i = 0; i < rows; i++) {

	   printf("%i",i+1);
	   printf("|");
     for (j = 0; j < cols; j++) {
       printf("%c ", myArray[i][j]);
     }printf("|");
     printf("%i",i+1);
     printf("\n");
   }
   printf("  -------------------\n");
   printf("  1 2 3 4 5 6 7 8 9\n");
 }

 void deleteArray(char** myArray, int rows, int cols) {
	 int i = 0;
   for ( i = 0; i < rows; i++) {
     free(myArray[i]);
   }
   free(myArray);

   return;
 }
