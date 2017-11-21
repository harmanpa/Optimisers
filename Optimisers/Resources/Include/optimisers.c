/*
 * (c) 2017 CAE Tech Limited
 */


#include <string.h>
#include <stdlib.h>

#include "optimisers.h"
#include "cobyla.h"
#include "newuoa.h"
#include "ModelicaUtilities.h"

typedef struct {
    int method;
    double* x;
    void* context;
    int n;
    int m;
} Optimiser_s;

void* Optimiser_Create(int method, int n, int m, double rhobeg, double rhoend, int maxfun, int npt) {
    Optimiser_s* opt;
    opt = (Optimiser_s*) malloc(sizeof (Optimiser_s));
    opt->method = method;
    opt->n = n;
    opt->m = m;
    opt->x = (double*) malloc(n * sizeof (double));
    switch (method) {
        case OPTIMISERS_METHOD_COBYLA:
            opt->context = (void*) cobyla_create(n, m, rhobeg, rhoend, 1, (long) maxfun);
            return (void*) opt;
        case OPTIMISERS_METHOD_NEWUOA:
            opt->context = (void*) newuoa_create(n, (long) npt, rhobeg, rhoend, 1, (long) maxfun);
            return (void*) opt;
        default:
            // Error
            ModelicaError("Unknown method");
            return (void*) opt;
    }
}

int Optimiser_Restart(void* optp) {
    Optimiser_s* opt;
    opt = (Optimiser_s*) optp;
    switch (opt->method) {
        case OPTIMISERS_METHOD_COBYLA:
            cobyla_restart((cobyla_context_t*) opt->context);
            return 1;
        case OPTIMISERS_METHOD_NEWUOA:
            newuoa_restart((newuoa_context_t*) opt->context);
            return 1;
        default:
            // Error
            ModelicaError("Unknown method");
            return 0;
    }
}

int Optimiser_Iterate(void* optp, double* xIn, double fIn, double* cIn, double* xOut) {
    Optimiser_s* opt;
    int status;
    int out = 0;
    opt = (Optimiser_s*) optp;
    memcpy(opt->x, xIn, opt->n * sizeof (double));
    switch (opt->method) {
        case OPTIMISERS_METHOD_COBYLA:
            status = cobyla_iterate((cobyla_context_t*) opt->context, fIn, opt->x, cIn);
            if (status == COBYLA_ITERATE) {
                out = 1;
            }
            if (status < 0) {
                ModelicaError(cobyla_reason(status));
            }
            break;
        case OPTIMISERS_METHOD_NEWUOA:
            status = newuoa_iterate((newuoa_context_t*) opt->context, fIn, opt->x);
            if (status == NEWUOA_ITERATE) {
                out = 1;
            }
            if (status < 0) {
                ModelicaError(newuoa_reason(status));
            }
            break;
        default:
            // Error
            ModelicaError("Unknown method");
            break;
    }
    memcpy(xOut, opt->x, opt->n * sizeof (double));
    return out;
}

void Optimiser_Destroy(void* optp) {
    Optimiser_s* opt;
    opt = (Optimiser_s*) optp;
    free(opt->x);
    switch (opt->method) {
        case OPTIMISERS_METHOD_COBYLA:
            cobyla_delete((cobyla_context_t*) opt->context);
            break;
        case OPTIMISERS_METHOD_NEWUOA:
            newuoa_delete((newuoa_context_t*) opt->context);
            break;
        default:
            // Error
            ModelicaError("Unknown method");
            break;
    }
    free(opt);
}