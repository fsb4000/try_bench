#include "CExceptionConfig.h"

#include <assert.h>
#include <stdbool.h>
#include <iso646.h>

#include <pthread.h>

static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
static bool stacks[CEXCEPTION_NUM_ID] = {false};
thread_local static unsigned int stack = 0u;

EXTERN_C unsigned int GetCurrentStack() NOEXCEPT
{
    return stack;
}

EXTERN_C void AcquireStack() NOEXCEPT
{
    bool found = false;
    int res = pthread_mutex_lock (&mutex);
    assert (res == 0);
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
    res = pthread_mutex_unlock (&mutex);
    assert (res == 0);
    assert (found);
}

EXTERN_C void ReleaseStack() NOEXCEPT
{
    int res = pthread_mutex_lock (&mutex);
    assert (res == 0);
    assert (stacks[stack]);
    stacks[stack] = false;
    res = pthread_mutex_unlock (&mutex);
    assert (res == 0);
}

EXTERN_C void InitCException() NOEXCEPT
{}

EXTERN_C void CleanupCException() NOEXCEPT
{
    int res = pthread_mutex_destroy (&mutex);
    assert (res == 0);
}
