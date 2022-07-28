FUNCTION z_00_add.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IV_ZAHL1) TYPE  INT4
*"     REFERENCE(IV_ZAHL2) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_SUMME) TYPE  INT4
*"  EXCEPTIONS
*"      WRONG_IMPORT
*"----------------------------------------------------------------------
  IF iv_zahl1 NE 0 AND iv_zahl2 IS NOT INITIAL.
    ev_summe = iv_zahl1 + iv_zahl2.
    gv_gesamtsumme = gv_gesamtsumme + ev_summe.
    gs_summen-zahl1 = iv_zahl1.
    gs_summen-zahl2 = iv_zahl2.
    gs_summen-summe = ev_summe.
    INSERT gs_summen into table gt_summen.
  ELSE.
    RAISE wrong_import.
  ENDIF.

ENDFUNCTION.
