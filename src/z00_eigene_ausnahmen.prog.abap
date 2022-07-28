*&---------------------------------------------------------------------*
*& Report Z00_SYSTEMAUSNAHMEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_eigene_ausnahmen.

PARAMETERS: pa_int1 TYPE i,
            pa_int2 TYPE i.

DATA gv_result TYPE i.
DATA go_error TYPE REF TO cx_root.

TRY.
    PERFORM rechne USING  pa_int1
                          pa_int2
                   CHANGING gv_result.
    WRITE: / 'Multiplikation', gv_result.

  CATCH   cx_root INTO go_error ."cx_sy_zerodivide cx_sy_arithmetic_overflow.
    MESSAGE go_error->get_text( ) TYPE 'I'.
ENDTRY.
ULINE.
WRITE 'Programmende'.

**********************************************************************
FORM rechne USING VALUE(p_int1) TYPE i  "Call by Value and result
                  VALUE(p_int2) TYPE i
            CHANGING VALUE(p_result) TYPE i
            RAISING zcx_00_bc401_nk
                    cx_sy_zerodivide.


  TRY.
      "Regel: gv_result nicht > 10000
      p_result = p_int1 * p_int2.  "Überlauf
      IF p_result > 10000.
        RAISE EXCEPTION TYPE zcx_00_bc401_nk
          EXPORTING
            textid = zcx_00_bc401_nk=>hoechstwert_ueberschritten
            wert1  = 10000
            wert2  = p_result.
      ENDIF.

      IF p_result < 0.
        RAISE EXCEPTION TYPE zcx_00_bc401_nk
          EXPORTING
            textid = zcx_00_bc401_nk=>minimalwert_unterschritten
            wert1  = 0
            wert2  = p_result.
      ENDIF.

    CATCH cx_root INTO DATA(lo_error).
      IF lo_error IS INSTANCE OF zcx_00_bc401_nk.
        RAISE EXCEPTION lo_error.
      ELSE.
        IF lo_error IS INSTANCE OF cx_sy_arithmetic_overflow.
          RAISE EXCEPTION TYPE cx_sy_zerodivide. " disvision durch 0
        ELSE.
          MESSAGE lo_error->get_text( ) TYPE 'I'.
        ENDIF.
      ENDIF.
  ENDTRY.




ENDFORM.
