*&---------------------------------------------------------------------*
*& Report Z00_CONSTRUCTOR
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_constructor.

CLASS  lcl DEFINITION.
  PUBLIC SECTION.
    "METHODS constructor IMPORTING iv_datum TYPE d.
    METHODS set_datum IMPORTING  iv_datum TYPE d OPTIONAL
                      EXCEPTIONS leer.

  PRIVATE SECTION.
    DATA mv_datum TYPE d.
    data mv_uname type syuname.
ENDCLASS.

CLASS lcl IMPLEMENTATION.
*  METHOD constructor.
*    mv_datum = iv_datum.
*    MESSAGE 'Methode wurde aufgerufen' TYPE 'I'.
*  ENDMETHOD.
  METHOD set_datum.
    IF iv_datum IS INITIAL.
      RAISE leer.
    ENDIF.
    mv_datum = iv_datum.
    mv_uname = sy-uname.
  ENDMETHOD.
ENDCLASS.

START-OF-SELECTION.
  DATA go_lcl TYPE REF TO lcl.
  CREATE OBJECT go_lcl." EXPORTING iv_datum = '20190531'


  go_lcl->set_datum(
    EXPORTING
    iv_datum = '00000000'
    EXCEPTIONS
      leer = 4 ).
  IF sy-subrc <> 0.
    CLEAR go_lcl.
  ENDIF.

  "go_lcl->set_datum( sy-datum ).
  "go_lcl->normale_methode( ).
  BREAK-POINT.
