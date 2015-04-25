/*
  Reverse a linked list and return pointer to the head
  The input list will have at least one element
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
