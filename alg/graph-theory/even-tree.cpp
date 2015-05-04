
#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>
using namespace std;

#if !defined(CLI_BUILD)
#include "HackerRank.h"
#endif

typedef vector< vector<bool> > AdjacencyMatrix;

 void TraceTree(const AdjacencyMatrix &graph) {
     size_t n = graph.size();
     vector<bool> visited(n);

     // TODO: hash map for edges and their counts

     for (int i = 0; i < n; i++) {
         for (int j = 0; j < n; j++) {
             // || adjMatrix[i][j].visited
             if (!graph[i][j]) {
                 continue;
             }
             printf("%d, %d\n", i, j);

             // adjMatrix[i][j].visited = true;
         }
     }
 }

void evenTreeCpp() {

    int n, m;
    cin >> n >> m;
    // cout << n << m << endl;

    // Adjacency matrix, aka graph representation
    AdjacencyMatrix graph(n);
    for (int i = 0; i < n; i++) {
        graph[i] = vector<bool>(n);
    }

    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;

        graph[u - 1][v - 1] = true;
        graph[v - 1][u - 1] = true;
    }

    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            cout << graph[i][j] << " ";
        }
        cout << endl;
    }

    // TODO: pick any vertex to start from and do a DFS search to put proper weights on the edges (aka count things)
    TraceTree(graph);

}

#ifdef CLI_BUILD
int main() {
    evenTreeCpp();
    return 0;
}
#endif