#include <math.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>
#include <limits.h>
#include <stdbool.h>

int main() {
    int t; 
    scanf("%d", &t);

    for (int i = 0; i < t; i++){
        int n; 
        scanf("%d", &n);
        
        // Inspired by https://www.quora.com/What-is-the-sum-of-1-to-100
        
        long long n3 = n / 3 - !(n % 3);
        long long n5 = n / 5 - !(n % 5);
        long long n15 = n / (5 * 3) - !(n % (5 * 3));
        
        long long sum3 = (n3 + 1) * 3 * n3 / 2;
        long long sum5 = (n5 + 1) * 5 * n5 / 2;
        long long sum15 = (n15 + 1) * (5 * 3) * n15 / 2;
        
        printf("%lld\n", (sum3 + sum5 - sum15));
    }

    return 0;
}
