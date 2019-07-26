# functions for performing operations on matricies in Zeek

function map_1 (f: function(a: count): count, v: vector of count) : vector of count
    {
    local out: vector of count;

    for ( i in v )
        out += f(v[i]);
    
    return out;
    }

function make_1_mapper(f: function(a: count): count):
    function(v: vector of count) : vector of count
    {
    return function(v: vector of count) : vector of count
        {
        local out: vector of count;
        for ( i in v)
            out += f(v[i]);
        return out;
        };
    }

event zeek_init()
    {
    local make_laster = function(start: count) : function(i: count): count
        {
        return function(i: count): count
            {
            local temp = i;
            i += start;
            start = temp;
            return i;
            };
        };

    local test = vector(1, 2, 3);
    print map_1(make_laster(0), test);
    }