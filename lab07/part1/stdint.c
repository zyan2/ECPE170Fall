#include <stdio.h>  
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <stdint.h>
#include <inttypes.h>

int main()
{
    uint32_t array1[3][5]; //create a 2-d array
    uint32_t array2[3][5][7]; //create a 3-d array
    printf("For the 2d-array\n");
    int i,j,k;
    for(i = 0; i <3; i++)
    {
    	for(j=0; j<5 ;j++)
    	{
    	    printf("located at row %"PRIu32" column %"PRIu32" \n", i+1, j+1);//show 2d array row and colum
    	    printf("array1 address = %p \n \n", &array1[i][j]);//show 2d array address
    	}
    }
    printf("we can see that every memory address 4 bit difference, which is right, because value type is uint32 which is 4 bit. so answer is option 2\n");
    
    printf("and for the 3d-array.\n");
    for(i = 0; i<3;i++)
    {
        for(j = 0;j < 5; j++)
        {
            for(k = 0;k <7; k++)
            {
            printf("located at  %"PRIu32"  %"PRIu32" %"PRIu32" \n", i+1, j+1,k+1);//show 3d array row and colum
    	    printf("array1 address = %p \n \n", &array2[i][j][k]);//show 3d array address
            }
        }
    }
    printf("it is same, option2 is right");
    return 0;
    
}
