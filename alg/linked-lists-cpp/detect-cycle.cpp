/*
  Detect loop in a linked list
  List could be empty also
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
int HasCycle(Node* head)
{
    Node *visited [100];
    int visitedIdx = 0;

    Node *node = head;
    while (node) {
        for (int i = 0; i < visitedIdx; i++) {
            if (node == visited[i]) {
                return 1;
            }
        }
        visited[visitedIdx++] = node;
        node = node->next;
    }
    return 0;
}
