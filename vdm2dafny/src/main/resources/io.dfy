module IO {
     method format(fstring: string, args: seq<string>) returns (RESULT: string) 
        decreases |args|
     {
        if args == [] {
            return fstring;

        } 
        var arg: string := args[0];
        var ptr: nat := 0;
        
        label findS: while (ptr < |fstring| - 1) 
        {
            if ptr - 1 >= 0 {
                if fstring[ptr] == '%' && fstring[ptr+1] == 's' && fstring[ptr-1] != '\\' {
                    break findS;
                }
            }
            else {
                if fstring[ptr] == '%' && fstring[ptr+1] == 's' {
                    break findS;
                }
            }
            ptr := ptr + 1;
        }
        if ptr >= |fstring| - 1 {
            return fstring;
        }
        var rptr := ptr + 2;
        RESULT := fstring[..ptr] + arg;

        if rptr >= |fstring| {
            RESULT := format(RESULT, args[1..]);
            return RESULT;
        }
        else {
            RESULT := format(RESULT + fstring[rptr..], args[1..]);
            return ;
        }

    }

    method Main() {
        var fstring := format("%s", ["Ce n'est pas moi %s", "quand je parle"]);
        print fstring;
    }
}