function stacker (one : function(a: count): count, two: function (b: count): count): function(c: count): count
    {
    return function (c: count): count
        {
        return one(two(c));
        };
    }

event zeek_init()
    {
    local times_two = function(i: count): count { return i*2; };
    local times_four = stacker(times_two, times_two);

    local times_eight = stacker(times_four, times_two);

    print times_eight(2);
    }