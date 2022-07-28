*&---------------------------------------------------------------------*
*& Report Z00_LINIE AIRPLANE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_linie_airplane

CLASS linie_airplane DEFINITION.



PUBLIC SECTION.
  CLASS-METHODS add
    IMPORTING
      iv_zahl1 TYPE i
      iv_zahl2 TYPE i
    EXPORTING
      ev_summe TYPE i
    EXCEPTIONS
      wrong_import.
PROTECTED SECTION.





PRIVATE SECTION.
  CLASS-DATA:
    mv_flugzeugname TYPE string,
    gs_summen       TYPE z00_summen,
    gt_summen       TYPE z00_tt_summen.

ENDCLASS.
CLASS lcl_lokal IMPLEMENTATION.
METHOD add.
  IF iv_zahl1 IS NOT INITIAL AND iv_zahl2 IS NOT INITIAL.
    ev_summe = iv_zahl1 + iv_zahl2.
    gv_gesamtsumme = gv_gesamtsumme + ev_summe.
  ELSE.
    RAISE wrong_import.
  ENDIF.
ENDMETHOD.
ENDCLASS.
* Hauptprogramm
DATA gv_summe TYPE i.
DATA gv_zahl TYPE decfloat34.

START-OF-SELECTION.
  CALL METHOD lcl_lokal=>add
    EXPORTING
      iv_zahl1     = -45
      iv_zahl2     = 12
    IMPORTING
      ev_summe     = gv_summe
    EXCEPTIONS
      wrong_import = 1.

  IF sy-subrc =  1.
    WRITE 'Mindestens ein Parameter war Null'.
  ELSE.
    WRITE: / 'Die berechnete Summe', gv_summe.
  ENDIF.
