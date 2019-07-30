##! Collection of functions for mapping functions to vectors and matricies.
##! Makes use of the any type to allow the functions to generalize well.

# Applies a function to a range of values and returns the result of that
# application in a new vector. Does not modify the input vector.
function transform (f: function(a: any): any, v: vector of any): vector of any
    {
    local r = vector();
    for (index in v)
        {
        r += f(v[index]);
        }
    return r;
    }

# Generates a function from a function that takes a vector as an argument
# and transforms it with the input function.
function make_transformer (f: function (a: any): any): function (b: vector of any): vector of any
    {
    return function (b: vector of any): vector of any
        {
        return transform(f, b);
        };
    }

event zeek_init()
    {
    # Add the last element we saw to the current element starting with start.
    local make_laster = function (start: count) : function (i: count): count
        {
        return function (i: count): count
            {
            local temp = i;
            i += start;
            start = temp;
            return i;
            };
        };

    # A simple transform.
    local test = vector(1, 2, 3);
    print transform(make_laster(0), test);

    # Is the input the same as my string?
    local same_as = function (mine: string): function (theirs: string): bool
        {
        return function (theirs: string): bool { return (mine == theirs); };
        };

    # Make a function to apply a transform.
    local same_transform = make_transformer(same_as("dog"));
    print same_transform(vector("dog", "cat", "dog", "fish"));

    # Use that function to apply a transform to a matrix.
    local matrix = vector(vector("dog", "not"), vector("not", "dog"));
    print transform(same_transform, matrix);
    }