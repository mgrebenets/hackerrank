/*
   Find merge point of two linked lists
   Node is defined as
   struct Node
   {
       int data;
       Node* next;
   }
*/
]int FindMergeNode(Node *headA, Node *headB)
{
    Node *nodeA = headA;
    while (nodeA) {
        Node *nodeB = headB;
        while (nodeB) {
            if (nodeA == nodeB) {
                return nodeA->data;
            }
            nodeB = nodeB->next;
        }
        nodeA = nodeA->next;
    }

    return 0;
}
