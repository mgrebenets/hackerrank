/*
  Get Nth element from the end in a linked list of integers
  Number of elements in the list will always be greater than N.
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
int GetNode(Node *head,int positionFromTail)
{
    Node *node = head;
    int i = 0;
    while (head) {
        // We have guarantee that length(list) > N
        if (i > positionFromTail) {
            node = node->next;
        }
        head = head->next;
        i++;
    }

    return node->data;
}
