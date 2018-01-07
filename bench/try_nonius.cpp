#define NONIUS_RUNNER
#include <nonius/nonius.h++>
#include <nonius/main.h++>

void thrower_cpp_const_char (int i)
{
    if (i == 0)
        throw "error";
}

int cpp_try_const_char (int i)
{
    volatile int res = 0;
    try
    {
        thrower_cpp_const_char (i);
    }
    catch (const char*)
    {
        res = 1;
    }
    return res;
}

NONIUS_BENCHMARK ("c++_try_const_char", [] (nonius::chronometer meter)
{
    int b = 1;
    meter.measure ([&] (const size_t /*run*/)
    {
        int res = cpp_try_const_char (b);
        assert (res == 0);
        return res;
    });
})

NONIUS_BENCHMARK ("c++_catch_const_char", [] (nonius::chronometer meter)
{
    int b = 0;
    meter.measure ([&] (const size_t /*run*/)
    {
        int res = cpp_try_const_char (b);
        assert (res == 1);
        return res;
    });
})
