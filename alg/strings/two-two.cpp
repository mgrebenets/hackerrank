/// Two Two
/// TODO: link

#include <iostream>
#include <map>
#include <vector>
#include <string>
#include <queue>
#include <cassert>
#include <cmath>
using namespace std;

#if !defined(CLI_BUILD)
#include "HackerRank.h"
#endif

typedef vector<string> PrefixSet;
typedef PrefixSet::iterator PrefixSetIterator;


class Trie {
public:
    typedef char ValueType;
    typedef map<ValueType, Trie*> TrieMap;
    typedef TrieMap::iterator TrieMapIterator;

    bool root;
    ValueType value;
    string label;
    int count;
    Trie *failNode;
    TrieMap nodes;

    Trie(int value = 0, bool root = false) {
        this->value = value;
        this->root = root;
        this->count = 0;
        this->failNode = NULL;
    }

    Trie *valueNode(ValueType value) {
        TrieMapIterator nodeIt = nodes.find(value);
        return (nodeIt != nodes.end() ? nodeIt->second : NULL);
    }

    Trie *addNode(ValueType value) {
        Trie *node = valueNode(value);
        if (node) {
            return node;
        } else {
            Trie *trie = new Trie(value);
            nodes[value] = trie;
            return trie;
        }
    }

    Trie *gotoNode(ValueType value) {
        Trie *node = valueNode(value);
        // Root node always goto to self if no valid path available
        return node ? node : (root ? this : NULL);
    }

    static Trie &buildTrie(PrefixSet &prefixSet) {
        Trie *rootNode = new Trie(0, true);

        // Phase I: build initial trie
        for (PrefixSetIterator it = prefixSet.begin(); it != prefixSet.end(); ++it) {
            Trie *node = rootNode;
            string prefix = *it;
            for (int i = 0; i < prefix.length(); i++) {
                node = node->addNode(prefix[i]);
            }
            node->label = prefix;
            node->count = 1;
        }

        // Phase II: construct goto and fail functions
        queue<Trie*> nodeQueue;
        for (TrieMapIterator it = rootNode->nodes.begin(); it != rootNode->nodes.end(); ++it) {
            Trie *nextNode = it->second;
            nextNode->failNode = rootNode;
            nodeQueue.push(nextNode);
        }

        while (!nodeQueue.empty()) {
            Trie *node = nodeQueue.front();
            nodeQueue.pop();

            for (TrieMapIterator it = node->nodes.begin(); it != node->nodes.end(); ++it) {
                ValueType value = it->first;
                Trie *nextNode = it->second;
                nodeQueue.push(nextNode);

                Trie *failNode = node->failNode;
                while (failNode->gotoNode(value) == NULL) {
                    failNode = failNode->failNode;
                }

                nextNode->failNode = failNode->gotoNode(value);
                nextNode->count += nextNode->failNode->count;
            }
        }

        return *rootNode;
    }

    int countMatches(string str) {
        int count = 0;
        Trie *node = this;

        for (int i = 0; i < str.length(); i++) {
            ValueType value = str[i];
            while (!node->gotoNode(value)) {
                node = node->failNode;
            }
            node = node->gotoNode(value);
            count += node->count;
        }

        return count;
    }
};

PrefixSet &buildPrefixSet(int maxPower) {
    PrefixSet *set = new PrefixSet();
    for (int p = 0; p <= maxPower; p++) {
        double po2 = pow(2, p);
        string po2String = to_string(po2);
        size_t lastDot = po2String.find_last_of(".");
        if (lastDot != string::npos) {
            po2String = po2String.substr(0, lastDot);
        }
        set->push_back(po2String);
    }

    return *set;
}

void twoTwoCpp() {
    PrefixSet prefixSet = buildPrefixSet(800);

    Trie trie = Trie::buildTrie(prefixSet);

    int n;
    cin >> n;
    for (int i = 0; i < n; i++) {
        string input;
        cin >> input;
        int count = trie.countMatches(input);
        cout << count << endl;
    }
}

#ifdef CLI_BUILD
int main() {
    twoTwoCpp();
    return 0;
}
#endif