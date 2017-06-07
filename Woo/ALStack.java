/*****************************************************
 * class ALStack
 * Implements a stack, generically typed.
 * Uses an ArrayList as underlying container.
 *****************************************************/

import java.util.ArrayList;
public class ALStack<T> implements Stack<T>
{
    private ArrayList<T> _stack;

    //constructor
    public ALStack()
    {
        _stack = new ArrayList<T>();
    }

    //overloaded constructor to allow for init capacity
    public ALStack( int size )
    {
        _stack = new ArrayList<T>(size);
    }

    //means of insertion
    public void push( T s )
    {
        _stack.add(0,s);
    }

    //means of viewing top element without removing
    public T peek( )
    {
        return _stack.get(0);
    }

    //means of removal
    public T pop( )
    {
        return _stack.remove(0);
    }


    //chk for emptiness
    public boolean isEmpty()
    {
        System.out.println(_stack.size());
        return _stack.size() == 0;
    }
    
}//end class ALStack