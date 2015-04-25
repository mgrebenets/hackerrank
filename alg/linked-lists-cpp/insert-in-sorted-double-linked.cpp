/*
    Insert Node in a doubly sorted linked list
    After each insertion, the list should be sorted
   Node is defined as
   struct Node
   {
     int data;
     Node *next;
     Node *prev
   }
*/
Node* SortedInsert(Node *head, int data)
{
    Node *newNode = (Node *)malloc(sizeof(Node));
    newNode->data = data;
    newNode->next = NULL;
    newNode->prev = NULL;

    Node *node = head;
    Node *prev = NULL;
    while (node) {
        if (data < node->data) {
            break;
        }
        prev = node;
        node = node->next;
    }

    if (!prev) {
        newNode->next = head;
        if (head) {
            head->prev = newNode;
        }
        head = newNode;
    } else {
        newNode->prev = prev;
        newNode->next = node;
        prev->next = newNode;
        if (node) {
            node->prev = newNode;
        }
    }

    return head;
}
