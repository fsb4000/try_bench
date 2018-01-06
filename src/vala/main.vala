public errordomain Error
{
    Thrower,
}

void thrower (int i)  throws Error
{
    if (i == 0)
        throw new Error.Thrower ("error");
}

int vala_try (int i)
{
    int res;
    try
    {
        thrower (i);
        res = 0;
    }
    catch (Error e)
    {
        (void)e;
        res = 1;
    }
    return res;
}

void main()
{
}
