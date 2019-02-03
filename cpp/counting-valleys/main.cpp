#ifdef __APPLE__
#   include <fstream>
#   include <iostream>
#else
#   include <bits/stdc++.h>
#endif

using namespace std;

// Complete the countingValleys function below.
int countingValleys(int n, string s) {
    int see_level = 0;
    int result = 0;

    for (char d : s) {
        int delta = d == 'U' ? 1 : -1;
        see_level += delta;

        if (delta == 1 && see_level == 0) {
            result++;
        }
    }

    return result;
}

int main()
{
    ofstream fout(getenv("OUTPUT_PATH"));

    int n;
    cin >> n;
    cin.ignore(numeric_limits<streamsize>::max(), '\n');

    string s;
    getline(cin, s);

    int result = countingValleys(n, s);

    fout << result << "\n";

    fout.close();

    return 0;
}

