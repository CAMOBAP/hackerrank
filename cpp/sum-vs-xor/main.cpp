#ifndef __clang__
#include <bits/stdc++.h>
#endif

#include <iostream>
#include <fstream>

using namespace std;

string ltrim(const string &);
string rtrim(const string &);

// Complete the sumXor function below.
unsigned long long sumXor(unsigned long long n) {
    if (n == 0) {
        return 1LL;
    }

    auto zeros = __builtin_popcountll(~n) - __builtin_clzll(n);
    
    return 1LL << zeros;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    string n_temp;
    getline(cin, n_temp);

    auto n = stoull(ltrim(rtrim(n_temp)));

    auto result = sumXor(n);

    fout << result << "\n";

    fout.close();

    return 0;
}

string ltrim(const string &str) {
    string s(str);

    s.erase(
        s.begin(),
        find_if(s.begin(), s.end(), not1(ptr_fun<int, int>(isspace)))
    );

    return s;
}

string rtrim(const string &str) {
    string s(str);

    s.erase(
        find_if(s.rbegin(), s.rend(), not1(ptr_fun<int, int>(isspace))).base(),
        s.end()
    );

    return s;
}

