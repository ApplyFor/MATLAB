#include <math.h>
#include "mex.h"
#include "matrix.h"

// L: dimension (#rows) of the input points
// N1 and N2: #points in V1 and V2
// V1 and V2: inputs points (treated as vectors in MATLAB linear indexing order)
// D: output matrix (treated as vector in MATLAB linear indexing order)

void get_pair_d(int L, int N1, int N2, const double *V1, const double *V2, double *D)
{
     int i, j, q1, q2, iL;
     int k = 0; // for linear index into D
     double dv;
     for (i = 0; i < N2; i++) {
        q1 = i * L; // linear index offest in V2
        for (j = 0; j<N1; j++) {
            q2 = j * L; // linear index offest in V1
            D[k] = 0;
            for (iL = 0; iL < L; iL++) {
                dv = V2[q1+iL] - V1[q2+iL];
                D[k] += dv * dv;
            }
            D[k] = sqrt(D[k]);
            k++;
        }
    }
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    /* input argument checking */
    if (nrhs != 2 || nlhs != 1) {
        mexErrMsgTxt("(get_pair_d) usage: D = get_pair_d(A,B)");
    }
    /* input A, B */
    double *A = mxGetPr(prhs[0]); //* pointer to the array content of A
    double *B = mxGetPr(prhs[0]); //* pointer to the array content of B
    int rA = mxGetM(prhs[0]); // # rows of A
    int rB = mxGetM(prhs[1]); // # rows of B
    int cA = mxGetN(prhs[0]); // # columns of A
    int cB = mxGetN(prhs[1]); // # columns of B
    mwSize ndimA = mxGetNumberOfDimensions(prhs[0]); // # dimensions of A
    mwSize ndimB = mxGetNumberOfDimensions(prhs[1]); // # dimensions of B
    int L=rA;
    /* output D */
    if(rA ~= rB){
        mexErrMsgTxt("(get_pair_d) usage: The two inputs must have the same number of rows.");
    }
    plhs[0] = mxCreateDoubleMatrix(ndimA[1], ndimB[1], mxREAL);
    double *D = mxGetPr(plhs[0]); //* pointer to the array content of D
    /* actual processing */
    get_pair_d(L, cA, cB, A, B, D);
}
