*&---------------------------------------------------------------------*
*& Report  BC400_DOS_COMPUTE
*&
*&---------------------------------------------------------------------*
*&
*& Simple calculator
*&---------------------------------------------------------------------*
REPORT  zbc401_dos_compute.
TRY.
    PARAMETERS:
      pa_int1 TYPE i,
      pa_op   TYPE c LENGTH 1,
      pa_int2 TYPE i.

    DATA gv_result TYPE p LENGTH 6 DECIMALS 2.

    IF ( pa_op = '+' OR
         pa_op = '-' OR
         pa_op = '*' OR
         pa_op = '/' ).

      CASE pa_op.
        WHEN '+'.
          gv_result = pa_int1 + pa_int2.
        WHEN '-'.
          gv_result = pa_int1 - pa_int2.
        WHEN '*'.
          gv_result = pa_int1 * pa_int2.
        WHEN '/'.
          gv_result = pa_int1 / pa_int2.
      ENDCASE.

      WRITE: 'Result:'(res), gv_result.

*    ELSEIF pa_op = '/' AND pa_int2 = 0.
*
*      WRITE 'No division by zero!'(dbz).

    ELSE.

      WRITE 'Invalid operator!'(iop).

    ENDIF.

  CATCH cx_root INTO DATA(go_error).
    MESSAGE go_error->get_text( ) TYPE 'I'.
ENDTRY.
