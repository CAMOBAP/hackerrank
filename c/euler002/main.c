#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int main(){
    int t; 
    scanf("%d",&t);
    for(int a0 = 0; a0 < t; a0++){
        long n; 
        scanf("%ld",&n);
        
        // E(n)can be expressed as E(n)= 4*E(n-1) + E(n-2)....
        int f1 = 2, f2 = 8, result = f1;
        while (f2 < n) {
            if (f2 % 2 == 0) {
                result += f2;   
            }
            
            int temp = f2;
            f2 = 4 * f2 + f1;
            f1 = temp;
            
        }
        printf("%d\n", result);
    }
    return 0;
}

