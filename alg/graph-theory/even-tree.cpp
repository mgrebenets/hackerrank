
#include <cmath>
#include <cstdio>
#include <vector>
#include <iostream>
#include <algorithm>

using namespace std;

struct Cell {
    bool adjacent;
    bool visited;
    int count;
};

#define MAX_N   100

// void TraceTree(Cell *adjMatrix[][], int n) {
//     for (int i = 0; i < n; i++) {
//         for (int j = 0; j < n; j++) {
//             // || adjMatrix[i][j].visited
//             if (!adjMatrix[i][j].adjacent) {
//                 continue;
//             }
//             printf("%d, %d\n", i, j);
//
//             // adjMatrix[i][j].visited = true;
//         }
//     }
// }

int main() {

    int n, m;
    cin >> n >> m;

    // cout << n << m << endl;

    Cell **graph = (Cell **)malloc(n * sizeof(Cell *));
    for (int i = 0; i < n; i++) {
        graph[i] = (Cell *)malloc(n * sizeof(Cell));
    }
    memset(graph, 0, n * n * sizeof(Cell));
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%d", graph[i][j].adjacent);
        }
    }

    Cell adjMatrix[MAX_N][MAX_N];
    memset(adjMatrix, 0, MAX_N * MAX_N * sizeof(Cell));

    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;

        int fu = u - 1, fv = v - 1;
        // printf("%d", graph[fu][fv]);
        // graph[fu][fv].adjacent = true;
        // graph[fv][fu].adjacent = true;

        adjMatrix[u - 1][v - 1].adjacent = true;
        adjMatrix[v - 1][u - 1].adjacent = true;

        // printf("[%d][%d]: %d\n", v, u, adjMatrix[v - 1][u - 1]);
        printf("[%d][%d]: %d [%d][%d]: %d\n", u, v, adjMatrix[u - 1][v - 1].adjacent, v, u, adjMatrix[v - 1][u - 1].adjacent);
    }

    // TODO: pick any vertex to start from and do a DFS search to put proper weights on the edges (aka count things)


    return 0;
}
