#include <cmath>
#include <cstdio>
#include <array>
#include <vector>
#include <iostream>
#include <algorithm>
#include <climits>

using namespace std;

#if !defined(CLI_BUILD)
#include "HackerRank.h"
#endif

typedef pair<int, int> Link;
typedef vector<Link> Jumps;

typedef vector< vector<int> > AdjacencyMatrix;

static const int gMaxDice = 6;
static const int gUndefined = -1;
static const int gInfinity = INT_MAX;
static const int gUnconnected = -1;

bool compareLinksByStart(const Link &a, const Link &b) {
    return a.first > b.first;   // Not >= (!)
}

bool compareLinksByEnd(const Link &a, const Link &b) {
    return a.second < b.second;
}

int rolls(int source, int destination) {
    return (destination - source) / gMaxDice + ((destination - source) % gMaxDice ? 1 : 0);
}

int shortestPath(const AdjacencyMatrix &graph, int source, int target) {
    // http://en.wikipedia.org/wiki/Dijkstra's_algorithm#Pseudocode

    size_t n = graph.size();
    vector<int> distance(n);
    vector<int> previous(n);
    vector<bool> unvisited(n);


    distance[source] = 0;
    previous[source] = gUndefined;

    // Initialization
    for (int v = 0; v < n; v++) {
        if (v != source) {
            distance[v] = gInfinity;
            previous[v] = gUndefined;
        }
        unvisited[v] = true;
    }

    int unvisitedCount = unvisited.size();
    while (unvisitedCount > 0) {
        // Get the u from unvisited with minimum distance[u]
        int u;
        int minDistance = gInfinity;
        for (int i = 0; i < unvisited.size(); i++) {
            if (!unvisited[i]) { continue; }
            if (distance[i] <= minDistance) {
                u = i;
                minDistance = distance[i];
            }
        }

        // Remove u from unvisited
        unvisited[u] = false;
        unvisitedCount--;

        // If u is the target, then we are done
        if (u == target) {
            break;
        }

        // Go through neighbours of u, this is where we need adjacency matrix
        for (int v = 0; v < n; v++) {
            if (graph[u][v] == gUnconnected) { continue; }
            if (!unvisited[v]) { continue; }    // v still in Q (unvisited)

            int alt = distance[u] + graph[u][v];
            if (alt < distance[v]) {
                distance[v] = alt;
                previous[v] = u;
            }
        }
    }

    // Time to traverse the path and collect the weights
    int u = target;
    int pathWeight = 0;
    while (previous[u] != gUndefined) {
        // cout << u << " -> " << previous[u] << " : " << graph[previous[u]][u] << endl;
        pathWeight += graph[previous[u]][u];
        u = previous[u];
    }

    return pathWeight;
}

int minRolls(int n, Jumps &jumps) {
    // Build a graph that contains all possible edges with proper weights
    // From each starting node can get to any other starting node, which has greater index
    // First (0) and last (n * m - 1) nodes are considered to be starting nodes
    // But can't go anywhere from last node
    // The weight of the edge is minimum number of rolls needed to get from start node to end node
    // Calculated as (end - start) / 6 + (end - start) % 6 ? 1 : 0

    // For jumps (snakes and ladders) the weight is 0, so eliminate jump edges as such
    // Use adjacency matrix representation which stored 0 if nodes are not connected
    // and an edge weight otherwise (since we fold jumps, there will be no edges with 0 weight)

    // UPD: have had problems with overlapping jumps
    // Such as jump from start to end would create duplicate edge (another edge came from ladder that jumped to the end)
    // So instead decided to keep all edges, including all the jumps with 0 weight
    // and have -1 as default value for no connection

    // UPD2: check the edge case, test cases 3, 4 and 5 are designed in such a way
    // that the problem is not solvable
    // 6 nodes before the end node are snakes that direct the player down
    // so it is not possible to reach the end ever
    // This edge case is checked separately

    // Sort the jumps by their starts (descending) to make checking easier
    sort(jumps.begin(), jumps.end(), compareLinksByStart);

    // Check the edge case
    bool unreachable = true;
    for (int i = 0; i < gMaxDice; i++) {
        if (jumps[i].first < n - gMaxDice - 1) {
            unreachable = false;
            break;
        }
    }

    if (unreachable) {
        return -1;
    }

    // Initialize graph
    AdjacencyMatrix graph(n);
    for (int i = 0; i < n; i++) {
        graph[i] = vector<int>(n);
        for (int j = 0; j < n; j++) {
            graph[i][j] = gUnconnected;
        }
    }

    // Connect start to the start of all jumps
    // Also map all jumps to the adjacency matrix with 0 weight
    for (Jumps::const_iterator jump = jumps.begin(); jump != jumps.end(); ++jump) {
        graph[0][jump->first] = rolls(0, jump->first);
        graph[jump->first][jump->second] = 0;
        // cout << 0 << " -> " << jump->first << " : " << graph[0][jump->first] << endl;
        // cout << jump->first << " -> " << jump->second << " : " << graph[jump->first][jump->second] << endl;
    }

    // Connect start to the end (for unlikely small board cases)
    graph[0][n - 1] = rolls(0, n - 1);
    // cout << 0 << " -> " << (n - 1) << " : " << graph[0][n - 1] << endl;

    // For all jumps connect their end to bigger starts of other jumps
    for (Jumps::const_iterator jump = jumps.begin(); jump != jumps.end(); ++jump) {
        for (Jumps::const_iterator otherJump = jumps.begin(); otherJump != jumps.end(); ++otherJump) {
            if (jump == otherJump) { continue; }

            // cout << jump->first << ":" << jump->second << " vs " << otherJump->first << ":" << otherJump->second << endl;
            if (jump->second < otherJump->first) {
                graph[jump->second][otherJump->first] = rolls(jump->second, otherJump->first);
                // cout << jump -> second << " -> " << otherJump->first  << " : " << graph[jump->second][otherJump->first] << endl;
            }
        }

        // And connect to the final node
        // Some jumps lead right to the end, so comparing to (n - 1) is appropriate
        if (jump->second < n - 1) {
            graph[jump->second][n - 1] = rolls(jump->second, n - 1);
            // cout << jump->second << " -> " << (n - 1) << " : " << graph[jump->second][n - 1] << endl;
        }
    }

    // Got the graph with weights, now just run shortest path on it from start (0) to end (n - 1)
    return shortestPath(graph, 0, n - 1);
}

void snakesAndLaddersCpp() {

    // Dimensions
    int rows = 10, cols = 10;

    // Number of tests
    int nTests;
    cin >> nTests;

    // Run each test
    for (int t = 0; t < nTests; t++) {
        // Read ladders
        int nLadders;
        cin >> nLadders;

        Jumps ladders(nLadders);
        for (int l = 0; l < nLadders; l++) {
            int start, end;
            cin >> start >> end;
            // Get into 0-based math from this moment on
            ladders[l] = make_pair(start - 1, end - 1);
        }

        // Read snakes
        int nSnakes;
        cin >> nSnakes;

        Jumps snakes(nSnakes);
        for (int s = 0; s < nSnakes; s++) {
            int start, end;
            cin >> start >> end;
            // Get into 0-based math from this moment on
            snakes[s] = make_pair(start - 1, end - 1);
        }

        // Combine all jumps
        Jumps jumps = ladders;
        jumps.insert(jumps.end(), snakes.begin(), snakes.end());

        // Solve
        cout << minRolls(rows * cols, jumps) << endl;
    }

}

#ifdef CLI_BUILD
int main() {
    snakesAndLaddersCpp();
    return 0;
}
#endif
