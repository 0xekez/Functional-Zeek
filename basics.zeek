

function add_n (n: count) : function (m: count) : count
    {
    return function (m: count): count { return m + n; };
    }

function stacker (one : function(a: count): count, two: function (b: count): count): function(c: count): count
    {
    return function (c: count): count
        {
        return one(two(c));
        };
    }

event zeek_init()
    {
    local times_two = function(n: count) : count
        { return n * 2; };

    local times_four = stacker(times_two, times_two);


    local where = 0;

    local make_counter = function() : function(): count
        { return function() { return ++n; }; };

    local counter = make_counter();
    print counter();
    print counter();

    local sneaky_counter = make_counter();
    print sneaky_counter();
    print sneaky_counter();

    ## now counter has different output
    print counter();

    local I = function (i: any) { print i; };

    I("dog");
    I(3);

    local map_I = function(f: function(a: any), v: vector of any)
        {
        for (index in v)
            f(v[index]);
        };

    map_I(I, vector("dog", "cat", "fish"));
    map_I(I, vector(1, 2, 3));

    local make_adder = function(n: count): function(m: count): count
        {
        return function (m: count): count
            {
            return n + m;
            };
        };

    local add_two = make_adder(2);
    local add_four = stacker(add_two, add_two);
    print add_four(4);
    }