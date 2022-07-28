*&---------------------------------------------------------------------*
*& Report Z00_CREATE_OBJECT_ALTERNATIV
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_create_object_alternativ.
CLASS lcl_air DEFINITION.
  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE string.
    DATA text TYPE string.
ENDCLASS.
CLASS lcl_air IMPLEMENTATION.
  METHOD constructor.

  ENDMETHOD.
ENDCLASS.

DATA go_air TYPE REF TO lcl_air.

START-OF-SELECTION.
  TRY.
      go_air = NEW #( iv_name = 'Berlin' iv_planetype = 'A380').
      DATA(go_air2) = NEW  lcl_air( iv_name = 'Köln' iv_planetype = 'A380' ).
      ..
      ..
    CATCH cx_root.
      "Fehler-Coding
  ENDTRY.





  CREATE OBJECT go_air
    EXPORTING
      iv_name      = 'Hamburg'
      iv_planetype = '747-400'.

  BREAK-POINT.
