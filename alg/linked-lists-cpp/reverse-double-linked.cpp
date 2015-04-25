/*
   Reverse a doubly linked list, input list may also be empty
   Node is defined as
   struct Node
   {
     int data;
     Node *next;
     Node *prev;
   }
*/
Node* Reverse(Node* head)
{
    Node *prev = NULL;
    Node *node = head;
    Node *next = NULL;
    while (node) {
        next = node->next;
        node->next = prev;
        node->prev = next;
        prev = node;
        node = next;
    }
    return prev;
}
