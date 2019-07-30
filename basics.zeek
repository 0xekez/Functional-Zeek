##! A couple examples to demonstrate the basics of using anonymous functions.

# Generates a function that adds n to its arguments.
function add_n (n: count) : function (m: count) : count
    {
    return function (m: count): count { return m + n; };
    }

# Stacks two functions
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

    print times_four(4); # 16

    local I = function (i: any) { print i; };

    I("dog");
    I(3);
    # Printing a function outputs the function's body without comments. 
    # For anonymous functions the function's unique identifier is also
    # included.
    I(I);

    # Anything that can be done with a regular function can be done with
    # a function declared in the global namespace.
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