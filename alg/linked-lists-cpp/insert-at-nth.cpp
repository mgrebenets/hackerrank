/*
  Insert Node at a given position in a linked list
  The linked list will not be empty and position will always be valid
  First element in the linked list is at position 0
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
Node* InsertNth(Node *head, int data, int position)
{
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;

    int i = 0;
    Node *prev = NULL;
    Node *node = head;
    while (node) {
        if (position == i) {
            break;
        }
        prev = node;
        node = node->next;
        i++;
    }

    
    newNode->next = node;
    if (!prev) {
        head = newNode;
    } else {
        prev->next = newNode;
    }

    return head;
}
