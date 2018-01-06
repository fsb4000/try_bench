#ifndef CPP_FOR_C_CODE_H
#define CPP_FOR_C_CODE_H

#pragma once

#ifndef _WIN32
#define FOPEN_CLOCKEXEC "e"
#else
#define FOPEN_CLOCKEXEC
#endif

#ifdef __cplusplus
#define EXTERN_C extern "C"
#else
#define EXTERN_C extern
#ifndef thread_local
#define thread_local _Thread_local
#endif
#endif

#if defined(__cplusplus) && ((__cplusplus >= 201103L) || (defined(_MSC_VER) && _MSC_VER >= 1900))
#define NOEXCEPT noexcept
#define CEXCEPTION noexcept
#else
#define NOEXCEPT
#define CEXCEPTION
#endif

#endif // CPP_FOR_C_CODE_H
