/*
 * (c) 2017 CAE Tech Limited
 */

#ifndef OPTIMISERS_H
#define OPTIMISERS_H

#ifdef __cplusplus
extern "C" {
#endif
    
#define OPTIMISERS_METHOD_COBYLA 1
#define OPTIMISERS_METHOD_NEWUOA 2

    void* Optimiser_Create(int method, int n, int m, double rhobeg, double rhoend, int maxfun, int npt);
    
    int Optimiser_Restart(void* optp);

    int Optimiser_Iterate(void* optp, double* xIn, double fIn, double* cIn, double* xOut);
    
    void Optimiser_Destroy(void* optp);
    

#ifdef __cplusplus
}
#endif

#endif /* OPTIMISERS_H */

