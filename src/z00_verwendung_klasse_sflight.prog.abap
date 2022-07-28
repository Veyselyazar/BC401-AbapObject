*&---------------------------------------------------------------------*
*& Report Z00_VERWENDUNG_FUBA
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_verwendung_klasse_sflight.

DATA gs_sflight TYPE sflight.
DATA: pa_int1 TYPE i, pa_int2 TYPE i.
DATA gv_text TYPE string.
DATA gv_summe TYPE i.
DATA gv_gesamt TYPE i.
DATA gt_summen TYPE z00_tt_summen.

SELECT  seatsocc seatsocc_f FROM sflight INTO (pa_int1, pa_int2)
  WHERE carrid = 'AA'.
  IF pa_int1 <> 0 AND pa_int2 <> 0.
*    CALL FUNCTION 'Z_00_ADD'
*      EXPORTING
*        iv_zahl1 = pa_int1
*        iv_zahl2 = pa_int2.
    CALL METHOD zcl_bc401=>add
      EXPORTING
        iv_zahl1 = pa_int1
        iv_zahl2 = pa_int2
*  IMPORTING
*       ev_summe =
*  EXCEPTIONS
*       wrong_import = 1
*       others   = 2
      .

  ENDIF.
ENDSELECT.


*CALL FUNCTION 'Z_00_GET_SUMME'
*  IMPORTING
*    ev_gesamtsumme = gv_gesamt
*"    et_summen      = gt_summen.
*.
CALL METHOD zcl_bc401=>get_summe
  IMPORTING
    ev_gesamtsumme = gv_gesamt
    et_summen      = gt_summen
*   ev_min         =
*   ev_max         =
*   ev_avg         =
  .



WRITE: / 'Gesamsumme', gv_gesamt.
LOOP AT gt_summen INTO DATA(gs_summen).
  WRITE: / gs_summen-zahl1,
           gs_summen-zahl2,
           gs_summen-summe.

ENDLOOP.
