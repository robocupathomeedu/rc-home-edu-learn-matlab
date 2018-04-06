/*
 * File: controllerSoln.h
 *
 * Code generated for Simulink model 'controllerSoln'.
 *
 * Model version                  : 1.19
 * Simulink Coder version         : 8.14 (R2018a) 06-Feb-2018
 * C/C++ source code generated on : Thu Mar 29 11:34:12 2018
 *
 * Target selection: ert.tlc
 * Embedded hardware selection: Intel->x86-64 (Windows64)
 * Code generation objectives: Unspecified
 * Validation result: Not run
 */

#ifndef RTW_HEADER_controllerSoln_h_
#define RTW_HEADER_controllerSoln_h_
#include <string.h>
#include <stddef.h>
#ifndef controllerSoln_COMMON_INCLUDES_
# define controllerSoln_COMMON_INCLUDES_
#include "rtwtypes.h"
#endif                                 /* controllerSoln_COMMON_INCLUDES_ */

#include "controllerSoln_types.h"

/* Macros for accessing real-time model data structure */
#ifndef rtmGetErrorStatus
# define rtmGetErrorStatus(rtm)        ((rtm)->errorStatus)
#endif

#ifndef rtmSetErrorStatus
# define rtmSetErrorStatus(rtm, val)   ((rtm)->errorStatus = (val))
#endif

/* Block states (default storage) for system '<Root>' */
typedef struct {
  real_T Integrator_DSTATE;            /* '<S2>/Integrator' */
  real_T Filter_DSTATE;                /* '<S2>/Filter' */
} DW_controllerSoln_T;

/* External inputs (root inport signals with default storage) */
typedef struct {
  real_T Desired;                      /* '<Root>/Desired' */
  real_T Actual;                       /* '<Root>/Actual' */
} ExtU_controllerSoln_T;

/* External outputs (root outports fed by signals with default storage) */
typedef struct {
  real_T ControlOut;                   /* '<Root>/ControlOut' */
} ExtY_controllerSoln_T;

/* Real-time Model Data Structure */
struct tag_RTM_controllerSoln_T {
  const char_T * volatile errorStatus;
};

/* Block states (default storage) */
extern DW_controllerSoln_T controllerSoln_DW;

/* External inputs (root inport signals with default storage) */
extern ExtU_controllerSoln_T controllerSoln_U;

/* External outputs (root outports fed by signals with default storage) */
extern ExtY_controllerSoln_T controllerSoln_Y;

/* Model entry point functions */
extern void controllerSoln_initialize(void);
extern void controllerSoln_step(void);
extern void controllerSoln_terminate(void);

/* Real-time Model object */
extern RT_MODEL_controllerSoln_T *const controllerSoln_M;

/*-
 * These blocks were eliminated from the model due to optimizations:
 *
 * Block '<Root>/Display' : Unused code path elimination
 * Block '<Root>/Scope' : Unused code path elimination
 * Block '<Root>/Scope1' : Unused code path elimination
 */

/*-
 * The generated code includes comments that allow you to trace directly
 * back to the appropriate location in the model.  The basic format
 * is <system>/block_name, where system is the system number (uniquely
 * assigned by Simulink) and block_name is the name of the block.
 *
 * Use the MATLAB hilite_system command to trace the generated code back
 * to the model.  For example,
 *
 * hilite_system('<S3>')    - opens system 3
 * hilite_system('<S3>/Kp') - opens and selects block Kp which resides in S3
 *
 * Here is the system hierarchy for this model
 *
 * '<Root>' : 'controllerSoln'
 * '<S1>'   : 'controllerSoln/Controller'
 * '<S2>'   : 'controllerSoln/Controller/Discrete PID Controller'
 */
#endif                                 /* RTW_HEADER_controllerSoln_h_ */

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
