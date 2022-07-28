*&---------------------------------------------------------------------*
*& Report Z00_VERWENDUNG_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_verwendung_fuba.

PARAMETERS: pa_int1 TYPE i,
            pa_int2 LIKE pa_int1.

DATA gv_text TYPE string.
DATA gv_summe TYPE i.
DATA gv_gesamt TYPE i.
DATA gt_summen TYPE z00_tt_summen.
DO 3 TIMES.
  CALL FUNCTION 'Z_00_ADD'
    EXPORTING
      iv_zahl1     = pa_int1 * sy-index
      iv_zahl2     = pa_int2 * sy-index
    EXCEPTIONS
      wrong_import = 123.
  IF sy-subrc <> 0.
    MESSAGE 'Zumindest ein Parameter ist 0' TYPE 'I'.
  ENDIF.
ENDDO.
CALL FUNCTION 'Z_00_GET_SUMME'
  IMPORTING
    ev_gesamtsumme = gv_gesamt
    et_summen      = gt_summen.
.


WRITE: / 'Gesamsumme', gv_gesamt.
LOOP AT gt_summen INTO DATA(gs_summen).
  WRITE: / gs_summen-zahl1,
           gs_summen-zahl2,
           gs_summen-summe.

ENDLOOP.
