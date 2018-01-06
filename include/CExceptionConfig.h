#ifndef CEXCEPTIONCONFIG_H
#define CEXCEPTIONCONFIG_H

#include <stddef.h>

#include "cpp_for_c_code.h"

#define CEXCEPTION_T const char*

#define CEXCEPTION_NONE (NULL)

#define CEXCEPTION_GET_ID    (GetCurrentStack())

#define CEXCEPTION_NUM_ID (64)

EXTERN_C unsigned int GetCurrentStack (void) NOEXCEPT;

EXTERN_C void InitCException (void) NOEXCEPT;

EXTERN_C void CleanupCException (void) NOEXCEPT;

EXTERN_C void AcquireStack (void) NOEXCEPT;

EXTERN_C void ReleaseStack (void) NOEXCEPT;

#endif
