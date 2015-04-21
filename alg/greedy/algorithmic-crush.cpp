#include <iostream>
#include <utility>
#include <vector>
#include <array>
#include <algorithm>

using namespace std;

// TC4: 7542539201
// TC5: 2510535321

// Sigh... thanks, editorial...

typedef long long int ValueType;
typedef pair<ValueType, ValueType> Pair;

bool compare(Pair p, Pair q) {
    if (p.first != q.first) {
        return p.first < q.first;
    } else {
        return p.second > q.second;
    }
}

// The idea of doing +k for each of N elements is _wrong_
// with the N around 10^7 it becomes tedious
// so no +k obviously, instead some other logic, such as comparing a's and b's.

ValueType Answer[2000009];

int main() {

    ValueType n, m;
    cin >> n >> m;
    vector<Pair> v;

    for (ValueType i = 1; i <= m; i++) {
        ValueType a, b, k;
        cin >> a >> b >> k;
        v.push_back(make_pair(a, k));
        v.push_back(make_pair(b, -k));
    }

    sort(v.begin(), v.end(), compare);

    for (ValueType i = 0; i < 2 * m; i++) {
        Answer[i] = v[i].second;
    }

    for (ValueType i = 1; i < 2 * m; i++) {
        Answer[i] = Answer[i - 1] + Answer[i];
    }

    sort(Answer, Answer + 2 * m);

    cout << Answer[2 * m - 1] << endl;

    /* Enter your code here. Read input from STDIN. Print output to STDOUT */
    return 0;
}
