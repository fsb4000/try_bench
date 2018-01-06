#include "CExceptionConfig.h"

#include <assert.h>
#include <stdbool.h>
#include <iso646.h>

#include <Windows.h>

static CRITICAL_SECTION init (void) NOEXCEPT
{
    CRITICAL_SECTION mutex;
    InitializeCriticalSection (&mutex);
    return mutex;
}

static CRITICAL_SECTION mutex;
static bool stacks[CEXCEPTION_NUM_ID] = {false};
thread_local static unsigned int stack = 0u;

EXTERN_C unsigned int GetCurrentStack() NOEXCEPT
{
    return stack;
}

EXTERN_C void AcquireStack() NOEXCEPT
{
    bool found = false;
    EnterCriticalSection (&mutex);
    for (unsigned int i = 1; i < CEXCEPTION_NUM_ID; ++i)
    {
        if (not stacks[i])
        {
            stacks[i] = true;
            stack = i;
            found = true;
            break;
        }
    }
    LeaveCriticalSection (&mutex);
    assert (found);
}

EXTERN_C void ReleaseStack() NOEXCEPT
{
    EnterCriticalSection (&mutex);
    assert (stacks[stack]);
    stacks[stack] = false;
    LeaveCriticalSection (&mutex);
}

EXTERN_C void InitCException() NOEXCEPT
{
    mutex = init();
}

EXTERN_C void CleanupCException() NOEXCEPT
{
    DeleteCriticalSection (&mutex);
}
