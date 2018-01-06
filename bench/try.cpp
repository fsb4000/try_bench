#include <benchpress/benchpress.hpp>
#include <cassert>
#include <stdexcept>

#include "cexception/CException.h"

/* Vala*/
#include <glib.h>
#include <glib-object.h>

#define _g_error_free0(var) ((var == NULL) ? NULL : (var = (g_error_free (var), NULL)))

typedef enum  {
	ERROR_Thrower
} Error;
#define ERROR error_quark ()


GQuark error_quark (void);
void thrower (gint i, GError** error);
gint _vala_main (void);


GQuark error_quark (void) {
	return g_quark_from_static_string ("error-quark");
}


void thrower (gint i, GError** error) {
	gint _tmp0_;
	GError * _inner_error_ = NULL;
	_tmp0_ = i;
	if (_tmp0_ == 0) {
		GError* _tmp1_;
		_tmp1_ = g_error_new_literal (ERROR, ERROR_Thrower, "error");
		_inner_error_ = _tmp1_;
		if (_inner_error_->domain == ERROR) {
			g_propagate_error (error, _inner_error_);
			return;
		} else {
			g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return;
		}
	}
}


gint vala_try (gint i) {
	volatile gint result = 0;
	gint res = 0;
	GError * _inner_error_ = NULL;
	res = 0;
	{
		thrower (i, &_inner_error_);
		if (G_UNLIKELY (_inner_error_ != NULL)) {
			gint _tmp0_ = 0;
			if (_inner_error_->domain == ERROR) {
				goto __catch0_error;
			}
			g_critical ("file %s: line %d: unexpected error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
			g_clear_error (&_inner_error_);
			return _tmp0_;
		}
	}
	goto __finally0;
	__catch0_error:
	{
		GError* e = NULL;
		GError* _tmp1_;
		e = _inner_error_;
		_inner_error_ = NULL;
		_tmp1_ = e;
		res = 1;
		_g_error_free0 (e);
	}
	__finally0:
	if (G_UNLIKELY (_inner_error_ != NULL)) {
		gint _tmp2_ = 0;
		g_critical ("file %s: line %d: uncaught error: %s (%s, %d)", __FILE__, __LINE__, _inner_error_->message, g_quark_to_string (_inner_error_->domain), _inner_error_->code);
		g_clear_error (&_inner_error_);
		return _tmp2_;
	}
	result = res;
	return result;
}

BENCHMARK("vala_try", [](benchpress::context* ctx)
{
	int res = -5;
	volatile int b = 1;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = vala_try(b);
		assert(res == 0 && "vala");
		benchpress::escape(static_cast<void*>(&res));
	}
})

BENCHMARK("vala_catch", [](benchpress::context* ctx)
{
	int res = -5;
	int b = 0;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = vala_try(b);
		assert(res == 1);
		benchpress::escape(static_cast<void*>(&res));
	}
})
/* VALA ENDS*/

void thrower_cpp(int i)
{
    if (i == 0)
        throw std::runtime_error("error");
}

int cpp_try(int i)
{
    volatile int res = 0;
    try
    {
        thrower_cpp(i);
    }
    catch(const std::exception&)
    {
        res = 1;
    }
    return res;
}

BENCHMARK("c++_try", [](benchpress::context* ctx)
{
	int res = -5;
	int b = 1;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = cpp_try(b);
		assert(res == 0);
		benchpress::escape(static_cast<void*>(&res));
	}
})

BENCHMARK("c++_catch", [](benchpress::context* ctx)
{
	int res = -5;
    int b = 0;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = cpp_try(b);
		assert(res == 1);
		benchpress::escape(static_cast<void*>(&res));
	}
})

void thrower_c(int i)
{
    if (i == 0)
        Throw("error");
}

int cexception_try(int i)
{
    volatile int res = 0;
    CEXCEPTION_T e = CEXCEPTION_NONE;
    Try
    {
        thrower_c(i);
    }
    Catch(e)
    {
        res = 1;
    }
    return res;
}

const char* noexcept_thrower_c(int i)
{
    if (i == 0)
        return "error";
    return nullptr;
}

int noexcept_try(int i)
{
    volatile int res = 0;
    if (noexcept_thrower_c(i) != nullptr)
    {
        res = 1;
    }
    return res;
}


BENCHMARK("noexcept_try", [](benchpress::context* ctx)
{
	int res = -5;
    int b = 1;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = noexcept_try(b);
		assert(res == 0);
		benchpress::escape(static_cast<void*>(&res));
	}
})

BENCHMARK("noexcept_catch", [](benchpress::context* ctx)
{
	int res = -5;
	int b = 0;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = noexcept_try(b);
		assert(res == 1);
		benchpress::escape(static_cast<void*>(&res));
	}
})

BENCHMARK("Cexception_try", [](benchpress::context* ctx)
{
	int res = -5;
	int b = 1;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = cexception_try(b);
		assert(res == 0);
		benchpress::escape(static_cast<void*>(&res));
	}
})

BENCHMARK("Cexception_catch", [](benchpress::context* ctx)
{
	int res = -5;
	int b = 0;

	ctx->reset_timer();
	for (size_t i = 0; i < ctx->num_iterations(); ++i)
	{
		res = cexception_try(b);
		assert(res == 1);
		benchpress::escape(static_cast<void*>(&res));
	}
})
