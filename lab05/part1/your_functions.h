#ifndef YOUR_FUNCTIONS_H
#define YOUR_FUNCTIONS_H

void quickSort(int *array_start, int start_pos, int end_pos);

void mergeSort(int *array_start, int *temp_array_start, int array_size);
void mergeSort_sort(int *array_start, int *temp_array_start, int left, int right);
void mergeSort_merge(int *array_start, int *temp_array_start, int left, int mid, int right);

// Students: Feel free to add other functions as needed here...

#endif // YOUR_FUNCTIONS_H

