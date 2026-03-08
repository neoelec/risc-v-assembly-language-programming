//
// Code snippets for Chapter 6
// Examples of using the stack and calling
// functions.
//

.global _start                  // Provide program starting address to linker

    .equ    rne,0
    .equ    rtz,1
    .equ    rdn,2
    .equ    rup,3
    .equ    rmm,4
    .equ    dyn,7

_start:
// fcsr pseudoinstructions
    frcsr   t0                  // read the fcsr into t0
    fscsr   t1,t0               // t1 = old value fcsr, fcsr = t0
    fscsr   t1                  // write fcsr = t1
    frrm    t0                  // read rounding mode into t0
    fsrm    t1,t0               // swap rounding mode with t0
    fsrm    t1                  // write rounding mode = X6
    fsrmi   t1,rtz              // swap rounding mode with immediate
    fsrmi   rtz                 // write rounding mode with immediate
    frflags t0                  // read exception flags
    fsflags t1,t0               // swap exception flags
    fsflags t1                  // write exception flags
    fsflagsi t1,rup             // swap exception flags with immediate
    fsflagsi rmm                // write exception flags with immediate

// load/store instructions
    la      t0,fp1              // load address of fp1
    flw     f0,0(t0)            // load single precision fp1
    fld     f1,4(t0)            // load double precision fp2
    fsw     f0,12(t0)           // store single precision fp3
    fsd     f1,16(t0)           // store double precision fp4

// Move instruction
    fmv.w.x f0,t0               // move 32-bits of t0 to f0
    fmv.x.w t0,f0               // move 32-bits of f0 to t0
    fmv.d.x f0,t0               // move 64-bits of t0 to f0
    fmv.x.d t0,f0               // move 64-bits of f0 to t0

// Pseudoinstructions
    fmv.s   f0,f1               // f0 = f1 single precision
    fmv.d   f0,f2               // f0 = f1 double precision

// Computation instructions
// fadd.h f0,f1,f2              // fd = fn + fm half precision
    fadd.s  f0,f1,f2,rne        // fd = fn + fm single precision
    fadd.d  f0,f1,f2            // fd = fn + fm double precision
// fadd.q f0,f1,f2              // fd = fn + fm quad precision
    fsub.d  f0,f1,f2            // fd = fn - fm
    fmul.d  f0,f1,f2            // fd = fn * fm
    fdiv.d  f0,f1,f2            // fd = fn / fm
    fmadd.d f0,f1,f2,f3         // fd = fa + fm * fn
    fmsub.d f0,f1,f2,f3         // fd = fm *fn - fa
    fnmsub.d f0,f1,f2,f3        // fd = fa - fm *fn
    fnmadd.d f0,f1,f2,f3        // fd = -fa - fm * fn
    fmax.d  f0,f1,f2            // fd = Max( fn, fm )
    fmin.d  f0,f1,f2            // fd = Min( fn, fm )
    fsqrt.d f0,f1               // fd = Square Root( fn )

    fneg.d  f0,f1               // fd = - fn
    fabs.d  f0,f1               // fd = Absolute Value( fn )

// Conversions
    fcvt.s.w f0,t0              // f0 = float(t0)
    fcvt.lu.d t0,f7,rup         // t0 = int(f7), rounding mode up
    fcvt.s.w f5,zero            // f5 = 0.0 single precision
    fcvt.d.w f5,zero            // f5 = 0.0 double precision
    fcvt.d.s f4,f5              // f4 (double) = f5 (single)
    fcvt.s.d f4,f5              // f4 (single) = f5 (double)

// Comparisons
    feq.s   t0,f4,f5            // if f4 = f5 then t0 = 1 else t0 = 0
    flt.d   t0,f4,f5            // if f4 < f5 then t0 = 1 else t0 = 0
    fle.d   t0,f4,f5            // if f4 ≤ f5 then t0 = 1 else t0 = 0

    fclass.d t0,f5              // classify double f5 putting result in t0

// Signs
    fsgnj.s f5,f6,f7            // t0 = abs(t1) with sign t2
    fsgnjn.d f5,f6,f7           // t0 = abs(t1) with sign -t2
    fsgnjx.d f5,f6,f7           // t0 = abs(t1) with sign(t1) xor sign(t2)

// Setup the parameters to exit the program
// and then call Linux to do it.
    li      a0,0                // Use 0 return code
    li      a7,93               // Service command code 1 terminates this program
    ecall                       // Call linux to terminate the program

.data
    .single 1.343,4.343e20,-0.4343,-0.4444e-10
    .double -4.24322322332e-10,3.141592653589793
fp1:
    .single 3.14159
fp2:
    .double 4.3341
fp3:
    .single 0.0
fp4:
    .double 0.0
