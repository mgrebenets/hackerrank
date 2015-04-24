/*
  Remove all duplicate elements from a sorted linked list
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
Node* RemoveDuplicates(Node *head)
{
  // This is a "method-only" submission.
  // You only need to complete this method.
  Node *node = head;
  while (node) {
      while (node->next && node->next->data == node->data) {
          node->next = node->next->next;
      }

      node = node->next;
  }
  return head;
}
