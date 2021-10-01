class Test
{
    public static void main(String[] args)
    {
        int bound = 5;
        dow(0, bound);
        wdo(0, bound);
        dow2(0, bound);

        dow(10,bound);
        wdo(10,bound);
        dow2(10, bound);
        
        dow(5,bound);
        wdo(5,bound);
        dow2(5, bound);
    }
    
    public static void dow(int x, int bound)
    {
        System.out.println("do-while from x="+x+", up to "+bound);
        do {
            x = x+1;
            System.out.println(x);
        } while (x<bound);
    }
    
    public static void wdo(int x, int bound)
    {
        System.out.println("while-do from x="+x+", up to "+bound);
        while (x<bound) {
            x = x+1;
            System.out.println(x);
        };        
    }
    
    public static void dow2(int x, int bound)
    {
        System.out.println("do-while with while-di from x="+x+", up to "+bound);
        boolean cond = true;
        while (cond) {
            x = x+1;
            System.out.println(x);
            cond = x < bound;
        };           
    }
}
