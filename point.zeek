
# A point is just a function that takes a action and an input and returns a
# double.
type point: function(action: string, other: double &default = -1): double;

function make_point (x: double, y: double): point
    {
    # Here is the crux of why this is so powerful. We have control
    # over how these values are used and mutated. If we wanted we
    # could move the point every time someone accessed its point.
    # We can't do that sort of thing with a record.
    local get_x = function(): double
        { return x; };
    local get_y = function(): double
        { return y; };

    # Sets and returns the old value.
    local set_x = function(new: double): double
        {
        local tmp = x;
        x = new;
        return tmp;
        };
    local set_y = function(new: double): double
        {
        local tmp = x;
        x = new;
        return tmp;
        };

    return function(action: string, other: double &default = -1): double
        {
        switch action
            {
            case "get_x":
                return get_x();
            case "get_y":
                return get_y();
            case "set_x":
                return set_x(other);
            case "set_y":
                return set_y(other);
            default:
                return -1;
            }
        };
    }

function distance(p1: point, p2: point): double
    {
    local square = function(x: double): double { return x*x; };
    local delta_x = p1("get_x") - p2("get_x");
    local delta_y = p1("get_y") - p2("get_y");
    return sqrt( square(delta_x) + square(delta_y) );
    }

event zeek_init()
    {
    local p1 = make_point(1, 1);
    local p2 = make_point(0, 0);
    print distance(p1, p2);
    }