*&---------------------------------------------------------------------*
*& Report Z00_FUNKTIONALE_METHODE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_funktionale_methode.

CLASS lcl_rechne DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS addiere
      IMPORTING VALUE(iv_zahl1) TYPE i DEFAULT 100
                iv_zahl2        TYPE i
      EXPORTING ev_text         TYPE string
      RETURNING VALUE(rt_summe) TYPE i.
    CLASS-METHODS display_brutto
      IMPORTING iv_netto         TYPE i
      RETURNING VALUE(rt_brutto) TYPE i.

ENDCLASS.
CLASS lcl_rechne IMPLEMENTATION.
  METHOD addiere.
    iv_zahl1 = iv_zahl1 + 1.
    IF iv_zahl1 IS NOT SUPPLIED.
      MESSAGE 'Parameter 1 ist nicht übergeben' TYPE 'I'.
    ENDIF.
    rt_summe = iv_zahl1 + iv_zahl2.
    ev_text = `Ergebnis lautet ` && rt_summe.
  ENDMETHOD.
  METHOD display_brutto.
    rt_brutto = iv_netto * '1.19'.
  ENDMETHOD.
ENDCLASS.

DATA gv_gesamtsumme TYPE i.

START-OF-SELECTION.
  DATA gv_zahl1 TYPE i VALUE 34.
  DATA gv_text TYPE string.
*  gv_gesamtsumme =  lcl_rechne=>addiere( iv_zahl1  = 20 iv_zahl2  = 10 )
*  +
*   lcl_rechne=>addiere( iv_zahl1  = 240 iv_zahl2  = 150 ).

*  IF lcl_rechne=>addiere( iv_zahl1  = 240 iv_zahl2  = 150 )
*    > 300.
*    WRITE 'Größer 300'.
*  ELSE.
*    WRITE 'kleiner gleich 300'.
*  ENDIF.

*  CALL METHOD lcl_rechne=>addiere
*    EXPORTING
*      iv_zahl1 = gv_zahl1
*      iv_zahl2 = 44
*    IMPORTING
*      ev_text  = gv_text
*    RECEIVING
*      rt_summe = gv_gesamtsumme.
*data gv_case type i value 390.
*gv_case = lcl_rechne=>addiere( iv_zahl1  = 240 iv_zahl2  = 150 ).
*  CASE lcl_rechne=>addiere( iv_zahl1  = 240 iv_zahl2  = 150 ).
*    WHEN 290.
*      WRITE 'treffer'.
*    WHEN lcl_rechne=>addiere( iv_zahl1  = 390 iv_zahl2  = 0 ).
*      WRITE ' ergebnis ist 390'.
*  ENDCASE.



 data(gv_brutto) =  lcl_rechne=>display_brutto( 100  )
     +   lcl_rechne=>display_brutto(  iv_netto = 300  ) .

  WRITE gv_brutto.
