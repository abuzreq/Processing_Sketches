//import KruskalDunguen.Cell; 
 
 public class Node<Cell> implements Comparable<Node<Cell>>
 {
        public Node(Cell data)
        {
          this.data= data;
        }
        void addChild(Node<Cell> child)
        {
            children.add(child);
        }
        void addAllChildren(ArrayList<Node<Cell>> childrenArray)
        {
          Set<Node<Cell>> set =  new LinkedHashSet<Node<Cell>>(children);
          set.addAll(childrenArray);
          children = new ArrayList<Node<Cell>>(set);
        }
        private Cell data;
        private Node<Cell> parent;
        private ArrayList<Node<Cell>> children = new ArrayList<Node<Cell>>();
        @Override
        public boolean equals(Object obj)
        {
          Node<Cell> other = (Node<Cell> )obj;
            return data.equals(other.data);
        }
        @Override
        public int hashCode()
        {

            return data.hashCode();
        }
        boolean isLeaf()
        {
          return children.size()==0;
        }
        int getValue(Node<Cell> node)
        {
          if(node.isLeaf())//base case
              return 0;
          int value = node.children.size();
          for(int i = 0;i< node.children.size();i++)
          {
            value += getValue(node.children.get(i)); 
          }
          return value;
            
        }
        
        @Override
        public int compareTo(Node<Cell> other)
        {
          int v1 = getValue(this);
          int v2 = getValue(other);
        //     println("CompareTo " + (v1-v2));
        //     println("I am "+this.toString()+" ,my value is = "+v1);
        //     println("I am "+other.toString()+" ,my value is = "+v2);
             
            return v1 - v2 ;
        }
         public String toString() 
          {
             return data.toString();
          }
 }