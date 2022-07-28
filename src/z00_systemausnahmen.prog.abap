*&---------------------------------------------------------------------*
*& Report Z00_SYSTEMAUSNAHMEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_systemausnahmen.

PARAMETERS: pa_int1 TYPE i,
            pa_int2 TYPE i.

DATA gv_result TYPE i.
data go_error TYPE REF TO cx_root.

TRY.
    gv_result = pa_int1 * pa_int2.  "Überlauf
    WRITE: / 'Multiplikation', gv_result.
    gv_result = pa_int1 / pa_int2. "Divide by Zero
    WRITE: / 'Division', gv_result.
    gv_result = pa_int1 ** pa_int2.
    write: / 'Potenzierung', gv_result.
  CATCH   cx_root into go_error ."cx_sy_zerodivide cx_sy_arithmetic_overflow.
    message go_error->get_text( ) type 'I'.
   " message 'Der Integer-Bereich wurde überschritten oder durch 0 dividiert' TYPE 'I'.
   " message 'es ist eine Sytemausnahme ausgelöst worden' type 'I'.
*  CATCH cx_sy_zerodivide.
*    MESSAGE 'es wurde versucht durch 0 zu dividieren' TYPE 'I'.
ENDTRY.
ULINE.
WRITE 'Programmende'.
