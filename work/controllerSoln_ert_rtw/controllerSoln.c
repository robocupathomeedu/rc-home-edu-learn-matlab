/*
 * File: controllerSoln.c
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

#include "controllerSoln.h"
#include "controllerSoln_private.h"

/* Block states (default storage) */
DW_controllerSoln_T controllerSoln_DW;

/* External inputs (root inport signals with default storage) */
ExtU_controllerSoln_T controllerSoln_U;

/* External outputs (root outports fed by signals with default storage) */
ExtY_controllerSoln_T controllerSoln_Y;

/* Real-time model */
RT_MODEL_controllerSoln_T controllerSoln_M_;
RT_MODEL_controllerSoln_T *const controllerSoln_M = &controllerSoln_M_;

/* Model step function */
void controllerSoln_step(void)
{
  real_T rtb_Sum;
  real_T rtb_FilterCoefficient;

  /* Sum: '<S1>/Sum' incorporates:
   *  Inport: '<Root>/Actual'
   *  Inport: '<Root>/Desired'
   */
  rtb_Sum = controllerSoln_U.Desired - controllerSoln_U.Actual;

  /* Gain: '<S2>/Filter Coefficient' incorporates:
   *  DiscreteIntegrator: '<S2>/Filter'
   *  Gain: '<S2>/Derivative Gain'
   *  Sum: '<S2>/SumD'
   */
  rtb_FilterCoefficient = (0.023 * rtb_Sum - controllerSoln_DW.Filter_DSTATE) *
    100.0;

  /* Sum: '<S2>/Sum' incorporates:
   *  DiscreteIntegrator: '<S2>/Integrator'
   *  Gain: '<S2>/Proportional Gain'
   */
  controllerSoln_Y.ControlOut = (0.3054 * rtb_Sum +
    controllerSoln_DW.Integrator_DSTATE) + rtb_FilterCoefficient;

  /* Saturate: '<S2>/Saturate' */
  if (controllerSoln_Y.ControlOut > 5.0) {
    /* Sum: '<S2>/Sum' incorporates:
     *  Outport: '<Root>/ControlOut'
     */
    controllerSoln_Y.ControlOut = 5.0;
  } else {
    if (controllerSoln_Y.ControlOut < -5.0) {
      /* Sum: '<S2>/Sum' incorporates:
       *  Outport: '<Root>/ControlOut'
       */
      controllerSoln_Y.ControlOut = -5.0;
    }
  }

  /* End of Saturate: '<S2>/Saturate' */

  /* Update for DiscreteIntegrator: '<S2>/Integrator' incorporates:
   *  Gain: '<S2>/Integral Gain'
   */
  controllerSoln_DW.Integrator_DSTATE += 0.081 * rtb_Sum * 0.01;

  /* Update for DiscreteIntegrator: '<S2>/Filter' */
  controllerSoln_DW.Filter_DSTATE += 0.01 * rtb_FilterCoefficient;
}

/* Model initialize function */
void controllerSoln_initialize(void)
{
  /* Registration code */

  /* initialize error status */
  rtmSetErrorStatus(controllerSoln_M, (NULL));

  /* states (dwork) */
  (void) memset((void *)&controllerSoln_DW, 0,
                sizeof(DW_controllerSoln_T));

  /* external inputs */
  (void)memset((void *)&controllerSoln_U, 0, sizeof(ExtU_controllerSoln_T));

  /* external outputs */
  controllerSoln_Y.ControlOut = 0.0;
}

/* Model terminate function */
void controllerSoln_terminate(void)
{
  /* (no terminate code required) */
}

/*
 * File trailer for generated code.
 *
 * [EOF]
 */
