#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "your_functions.h"

// Merge sort algorithm
// Arguments:
//  (1) Pointer to start of array to sort
//  (2) Pointer to start of temporary array
//  (3) Number of elements in array
// Return value: None
void mergeSort(int *array_start, int *temp_array_start, int array_size)
{
  printf("Using merge sort algorithm...\n");

  // Solution from: http://p2p.wrox.com/visual-c/66348-merge-sort-c-source-code.html

  mergeSort_sort(array_start, temp_array_start, 0, array_size - 1);

  return;
}

void mergeSort_sort(int array_start[], int temp[], int left, int right)
{
  int mid;
 
  if (right > left)
  {
    mid = (right + left) / 2;
    mergeSort_sort(array_start, temp, left, mid);
    mergeSort_sort(array_start, temp, mid+1, right);
 
    mergeSort_merge(array_start, temp, left, mid+1, right);
  }
}
 
void mergeSort_merge(int array_start[], int temp[], int left, int mid, int right)
{
  int i, left_end, num_elements, tmp_pos;
 
  left_end = mid - 1;
  tmp_pos = left;
  num_elements = right - left + 1;
 
  while ((left <= left_end) && (mid <= right))
  {
    if (array_start[left] <= array_start[mid])
    {
      temp[tmp_pos] = array_start[left];
      tmp_pos = tmp_pos + 1;
      left = left +1;
    }
    else
    {
      temp[tmp_pos] = array_start[mid];
      tmp_pos = tmp_pos + 1;
      mid = mid + 1;
    }
  }
 
  while (left <= left_end)
  {
    temp[tmp_pos] = array_start[left];
    left = left + 1;
    tmp_pos = tmp_pos + 1;
  }
  while (mid <= right)
  {
    temp[tmp_pos] = array_start[mid];
    mid = mid + 1;
    tmp_pos = tmp_pos + 1;
  }
 
  for (i=0; i < num_elements; i++)
  {
    // JAS: Used to be <= num_elements...
    array_start[right] = temp[right];
    right = right - 1;
  }
}


// Quick sort algorithm
// Arguments:
//  (1) Pointer to start of array
//  (2) Position of first element in (sub)array
//  (3) Position of last element in (sub)array
// Return value: None
void quickSort(int *a, int left, int right)
{
  //printf("Using quick sort algorithm...\n");
  if(left >= right)/*如果左边索引大于或者等于右边的索引就代表已经整理完成一个组了*/
    {
        return ;
    }
    int i = left;
    int j = right;
    int key = a[left];
     
    while(i < j) 
    {
        while(i < j && key <= a[j])
        
        {
            j--;
        }
         
        a[i] = a[j];
       
         
        while(i < j && key >= a[i])
       
        {
            i++;
        }
         
        a[j] = a[i];
    }
     
    a[i] = key;
    quickSort(a, left, i - 1);
    quickSort(a, i + 1, right);
  // (comment this printf() out if using a recursive implementation of quickSort)

  // XXXXXXXXXXXXXXXXXXXXXXXXXXX
  // YOUR CODE GOES HERE!
  // XXXXXXXXXXXXXXXXXXXXXXXXXXX

  // Feel free to create other helper functions
  // to assist with the quick sort
}
