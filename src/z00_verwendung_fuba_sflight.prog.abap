*&---------------------------------------------------------------------*
*& Report Z00_VERWENDUNG_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_verwendung_fuba_sflight.

DATA gs_sflight TYPE sflight.
data: pa_int1 type i, pa_int2 type i.
DATA gv_text TYPE string.
DATA gv_summe TYPE i.
DATA gv_gesamt TYPE i.
DATA gt_summen TYPE z00_tt_summen.

SELECT  seatsocc seatsocc_f FROM sflight INTO (pa_int1, pa_int2)
  WHERE carrid = 'AA'.
  IF pa_int1 <> 0 AND pa_int2 <> 0.
    CALL FUNCTION 'Z_00_ADD'
      EXPORTING
        iv_zahl1 = pa_int1
        iv_zahl2 = pa_int2.
  ENDIF.
ENDSELECT.


CALL FUNCTION 'Z_00_GET_SUMME'
  IMPORTING
    ev_gesamtsumme = gv_gesamt
"    et_summen      = gt_summen.
.


WRITE: / 'Gesamsumme', gv_gesamt.
*LOOP AT gt_summen INTO DATA(gs_summen).
*  WRITE: / gs_summen-zahl1,
*           gs_summen-zahl2,
*           gs_summen-summe.
*
*ENDLOOP.
