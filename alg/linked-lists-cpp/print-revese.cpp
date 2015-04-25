/*
  Print elements of a linked list in reverse order as standard output
  head pointer could be NULL as well for empty list
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/

Node* Reverse(Node *head)
{
    Node *prev = NULL;
    Node *node = head;
    Node *next = NULL;
    while (node) {
        next = node->next;
        node->next = prev;
        prev = node;
        node = next;
    }
    return prev;
}

void ReversePrint(Node *head)
{
    Node *reverse = Reverse(head);
    while (reverse) {
        printf("%d\n", reverse->data);
        reverse = reverse->next;
    }
}
