/*
  Delete Node at a given position in a linked list
  Node is defined as
  struct Node
  {
     int data;
     struct Node *next;
  }
*/
Node* Delete(Node *head, int position)
{
    if (!head) {
        // No head, no list
        return NULL;
    }

    int i = 0;
    Node *prev = NULL;
    Node *node = head;
    while (i < position && node) {
        prev = node;
        node = node->next;
        i++;
    }

    if (i < position) {
        // No such position in the list
        return head;
    }

    if (!prev) {
        // No previous node - remove head
        head = head->next;
    } else {
        prev->next = node->next;
    }

    return head;
}
