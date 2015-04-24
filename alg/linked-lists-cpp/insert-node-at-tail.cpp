/*
  Insert Node at the end of a linked list
  head pointer input could be NULL as well for empty list
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
Node* Insert(Node *head,int data)
{
  // Complete this method
  Node *newNode = (Node *)malloc(sizeof(Node));
  newNode->data = data;

  if (!head) {
      return newNode;
  }

  Node *lastNode = NULL;
  Node *node = head;
  while (node) {
      lastNode = node;
      node = node->next;
  }

  lastNode->next = newNode;
  return head;
}
