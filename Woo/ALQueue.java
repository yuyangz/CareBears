/*****************************************************
 * class ALQueue
 * uses an ArrayList to implement abstract data type QUEUE
 * (a collection with FIFO property)
 *
 *       -------------------------------
 *   end |  --->   Q U E U E   --->    | front
 *       -------------------------------
 * 
 * index 0 of ArrayList is front of queue
 ******************************************************/

import java.util.ArrayList;

public class ALQueue<T> implements Queue<T> 
{
    private ArrayList<T> _queue;

    // default constructor
    public ALQueue() 
	{ 
	    _queue = new ArrayList<T>(); 
	}


    // means of adding an item to collection 
    public void enqueue( T x ) 
    {
	_queue.add(x);
    }//O(1) expected, O(n) rarely


    // means of removing an item from collection 
    public T dequeue() 
    {
	return _queue.remove(0);
    }//O(n) bc n-1 shifted


    // means of "peeking" at the front item
    public T peekFront() 
    {
	return _queue.get(0);
    }//O(1)


    // means of checking to see if collection is empty
    public boolean isEmpty() 
    {
	return _queue.isEmpty();
    }//O(1)


    public String toString() 
    {
	return "front->" + _queue.toString() + "<-end";
    }//O(n)
}//end class ALQueue