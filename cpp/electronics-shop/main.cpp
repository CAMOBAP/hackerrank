#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

int main() {
    int s, n, m;
    std::cin >> s >> n >> m;
    
    std::vector<int> keyboard_prices, usb_prices;
    keyboard_prices.reserve(n);
    usb_prices.reserve(m);

    // https://stackoverflow.com/questions/22946772/keep-std-vector-list-sorted-while-insert-or-sort-all
    // No reason to do insertion sort

    for (int i = 0; i < n; i++) {
        int temp;
        std::cin >> temp;
        
        if (temp < s) {
            keyboard_prices.push_back(temp);
        }
    }
    
    for (int i = 0; i < m; i++) {
        int temp;
        std::cin >> temp;
        
        if (temp < s) {
            usb_prices.push_back(temp);
        }
    }

    std::sort(keyboard_prices.begin(), keyboard_prices.end());
    std::sort(usb_prices.begin(), usb_prices.end(), std::greater<int>());

    int result = -1;
    int ki = 0, ui = 0;
    for (auto ki = 0; ki < keyboard_prices.size(); ki++) {
        for (auto ui = 0; ui < usb_prices.size(); ui++) {
            auto new_result = keyboard_prices[ki] + usb_prices[ui];
            if (new_result > result && new_result <= s) {
                result = new_result;
            }
        }
    }
    
    std::cout << result << std::endl;
    
    return 0;
}
