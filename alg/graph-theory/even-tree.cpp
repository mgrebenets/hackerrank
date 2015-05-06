
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

// for each leaf node return 1 as the weight of the edge that leads to it
// for non-leaf nodes, return sum of all the outcoming edges
// if an node returns an even number, that means that edge that leads to that node
// has even weight, that means there's even number of nodes on each side of that edge
// thus it splits the tree in two even components
// so if the weight is even, increas the count of edges to be removed by 1

int TraceGraph(const AdjacencyMatrix &graph, int vertex, vector<bool> &visited, int *count) {
    // Mark as visited
    visited[vertex] = true;

    // Use 1 as default (will be the value for leaf nodes)
    int weight = 1;

    // Walk adjacent vertices
    for (int i = 0; i < graph.size(); i++) {
        if (visited[i]) { continue; }
        if (graph[vertex][i]) {
            // Trace each edge from this node
            int w = TraceGraph(graph, i, visited, count);
            // Check if that edge leads to another even tree
            if (w % 2 == 0) {
                *count += 1;
            }
            // Count total nodes, including current one
            weight += w;
        }
    }

    return weight;
}

int CountComponents(const AdjacencyMatrix &graph) {
    // pick any vertex to start from and do a DFS search to put proper weights on the edges (aka count things)
    // assume that input has no gaps in vertex indeces and pick 0 as starting vertex

    vector<bool> visited(graph.size());
    int count = 0;
    TraceGraph(graph, 0, visited, &count);
    return count;
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

    cout << CountComponents(graph) << endl;
}

#ifdef CLI_BUILD
int main() {
    evenTreeCpp();
    return 0;
}
#endif
