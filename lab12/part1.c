#include <stdio.h> 
#include <stdlib.h>
#include "part1.h"
char ArrayA[6][9];
int  m_z,m_w;
int main()
{

    int i;
    int j;
    printf("\nWelcome to Connect Four, Five-in-a-Row variant!\nVersion 1.0\nImplemented by Zhiyun Yan\n\n");
    
     for (i = 0;i<6;i++)
     {
        for(j = 0;j<9;j++)
        {
            ArrayA[i][j] = '.';
        }
     }
    
   
    ArrayA[0][0] = 'C';
    ArrayA[0][8] = 'C';
    ArrayA[2][0] = 'C';
    ArrayA[2][8] = 'C';
    ArrayA[4][0] = 'C';
    ArrayA[4][8] = 'C';
    ArrayA[1][0] = 'H';
    ArrayA[1][8] = 'H';
    ArrayA[3][0] = 'H';
    ArrayA[3][8] = 'H';
    ArrayA[5][0] = 'H';
    ArrayA[5][8] = 'H';
   
    printf("Enter two positive numbers to initialize the random number generator.\n");
    printf("Please input first number for random number generation");
        printf("\n");
        scanf("%d", &m_w);
        printf("Please input second number for random number generation");
        printf("\n");
        scanf("%d", &m_z);
        printf("\n");
        
        int turn = flipcoin();
        if(turn == 0)
        {
            printf("Coin Toss..Computer goes first.\n");
            while(checkwin()==0)
            {
                int PCmove;
                PCmove = generateRandomMove();
                while(PCmove>7 || PCmove<0)
                {
                  PCmove = generateRandomMove();	
                }
                int row;
                row = checkEmpty(PCmove);
                while(row ==-1)
                {
                    PCmove = generateRandomMove();
                while(PCmove>7 || PCmove<0)
                {
                  PCmove = generateRandomMove();	
                }
                row = checkEmpty(PCmove);
                }
                makemove(row,PCmove,'C');
                printArrayA();
                if(checkwin()==2)
                {
                    printArrayA();
                    printf("Computer win!");
                    return 0;
                }
                int Playermove;
         printf("What column would you like to drop token into? Enter 1-7:");
         scanf("%d",&Playermove);
         
                row = checkEmpty(Playermove);
                while(row == -1)
                {
                    printf("You cant do this.\n");
                    printf("What column would you like to drop token into? Enter 1-7:");
         scanf("%d",Playermove);
                    row =  checkEmpty(Playermove);
                }
                makemove(row,Playermove,'H');
                if(checkwin()==1)
                {
                    printArrayA();
                    printf("You win!");
                    return 0;
                }
            }
        
        }
        else if (turn == 1)
        {
            printf("Coin Toss..Human goes first.\n");
            while(checkwin()==0)
            {
                
                int Playermove;
                int row;
         printf("What column would you like to drop token into? Enter 1-7:");
         scanf("%d",Playermove);
         
                row = checkEmpty(Playermove);
                while(row == -1)
                {
                    printf("You cant do this.\n");
                    printf("What column would you like to drop token into? Enter 1-7:");
         scanf("%d",&Playermove);
                    row =  checkEmpty(Playermove);
                }
                makemove(row,Playermove,'H');
                if(checkwin()==1)
                {
                    printArrayA();
                    printf("You win!");
                    return 0;
                }
                int PCmove;
                PCmove = generateRandomMove();
                while(PCmove>7 || PCmove<0)
                {
                  PCmove = generateRandomMove();	
                }
                
                row = checkEmpty(PCmove);
                while(row ==-1)
                {
                    PCmove = generateRandomMove();
                while(PCmove>7 || PCmove<0)
                {
                  PCmove = generateRandomMove();	
                }
                row = checkEmpty(PCmove);
                }
                makemove(row,PCmove,'C');
                printArrayA();
                if(checkwin()==2)
                {
                    printArrayA();
                    printf("Computer win!");
                    return 0;
                }
            }

        }
        
    
    
    
    
    
    return 0;

}
void makemove(int x,int y, char z)
{
    ArrayA[x][y] = z;
}
int checkEmpty(int x)
{
  int i = 5;
    while(ArrayA[i][x]!='.')
    {
        if(i==-1)
        {
        return -1;
        }
        i--;
    }
    return i;
}
void printArrayA()
{
   int i;
   int j;
   printf("  1 2 3 4 5 6 7\n");
   printf("-----------------");
   printf("\n");
    for (i = 0;i<6;i++)
    {
    
        for(j = 0;j<9;j++)
        {
            printf("%c",ArrayA[i][j]);
            printf(" ");
        }
        printf("\n");
    }
   printf("-----------------");
   printf("\n");
}
int flipcoin()
{
    return get_random() % 2;
}    
int get_random()
{
   
    m_z = 36969 * (m_z & 65535) + (m_z >> 16);
    m_w = 18000 * (m_w & 65535) + (m_w >> 16);
    return (m_z << 16) + m_w;
}

 int checkwin()
 {
    int r, c;

   for (r = 0; r < 6; r++) 
   {

       for (c = 0; c < 9; c++) 
       {

          // check horizontal

          if (c < 5 && ArrayA[r][c] == 'H' && ArrayA[r][c+1] == 'H' &&
              ArrayA[r][c+2] == 'H' && ArrayA[r][c+3] == 'H' && ArrayA[r][c+4] == 'H')
              return 1; // human win

          if (c < 5 && ArrayA[r][c] == 'C' && ArrayA[r][c+1] == 'C' &&
              ArrayA[r][c+2] == 'C' && ArrayA[r][c+3] == 'C' && ArrayA[r][c+4] == 'C')
              return 2; // computer win

          // check vertical
 
          if (r < 2 && ArrayA[r][c] == 'H' && ArrayA[r+1][c] == 'H' &&
              ArrayA[r+2][c] == 'H' && ArrayA[r+3][c] == 'H' && ArrayA[r+4][c] == 'H')
              return 1; // human win

          if (r < 2 && ArrayA[r][c] == 'C' && ArrayA[r+1][c] == 'C' &&
              ArrayA[r+2][c] == 'C' && ArrayA[r+3][c] == 'C' && ArrayA[r+4][c] == 'C')
              return 2; // human win

          // check diagonal (right down)

          if (c < 5 && r < 2 && ArrayA[r][c] == 'H' && ArrayA[r+1][c+1] == 'H' &&
              ArrayA[r+2][c+2] == 'H' && ArrayA[r+3][c+3] == 'H' && ArrayA[r+4][c+4] == 'H')
              return 1; // human win

          if (c < 5 && r < 2 && ArrayA[r][c] == 'C' && ArrayA[r+1][c+1] == 'C' &&
              ArrayA[r+2][c+2] == 'C' && ArrayA[r+3][c+3] == 'C' && ArrayA[r+4][c+4] == 'C')
              return 2; // computer win

          // check diagonal (left down)

          if (c > 3 && r < 2 && ArrayA[r][c] == 'H' && ArrayA[r+1][c-1] == 'H' &&
              ArrayA[r+2][c-2] == 'H' && ArrayA[r+3][c-3] == 'H' && ArrayA[r+4][c-4] == 'H')
              return 1; // human win

          if (c > 3 && r < 2 && ArrayA[r][c] == 'C' && ArrayA[r+1][c-1] == 'C' &&
              ArrayA[r+2][c-2] == 'C' && ArrayA[r+3][c-3] == 'C' && ArrayA[r+4][c-4] == 'C')
              return 2; // computer win
        }
   }

   return 0;
 }


 int generateRandomMove()
{
    int x;
    x = (get_random() % 7) + 1;
    return x;
    
}    


