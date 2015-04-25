/*
  Merge two sorted lists A and B as one linked list
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
Node* MergeLists(Node *headA, Node* headB)
{
    Node *head = NULL;
    Node *node = NULL;
    Node *prev = NULL;
    while (nodeA || nodeB) {
        if (nodeA && nodeB) {
            if (nodeA->data < nodeB->data) {
                node = nodeA;
                nodeA = nodeA->next;
            } else {
                node = nodeB;
                nodeB = nodeB->next;
            }
        } else if (nodeA) {
            node = nodeA;
            nodeA = nodeA->next;
        } else {
            node = nodeB;
            nodeB = nodeB->next;
        }

        if (!prev) {
            head = node;
        } else {
            prev->next = node;
        }
        prev = node;
    }

    return head;
}
