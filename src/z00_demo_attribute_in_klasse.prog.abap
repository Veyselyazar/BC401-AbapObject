*&---------------------------------------------------------------------*
*& Report Z00_DEMO_ATTRIBUTE_IN_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_attribute_in_klasse.

CLASS lcl_lokal DEFINITION.
  PUBLIC SECTION.
    TYPES tv_name TYPE c LENGTH 17.
    METHODS set_name IMPORTING iv_name TYPE tv_name.
    DATA mv_name TYPE tv_name READ-ONLY.
    DATA r_string TYPE REF TO string.
  PRIVATE SECTION.
    METHODS check_input.
    CONSTANTS gc_pi TYPE p LENGTH 3 DECIMALS 2 VALUE '3.14'.
    class-data gv_counter type i.


ENDCLASS.
CLASS lcl_lokal IMPLEMENTATION.
  METHOD set_name.
    CALL METHOD check_input( ).
    mv_name = iv_name.
    add 1 to gv_counter.
  ENDMETHOD.
  METHOD check_input.

  ENDMETHOD.
ENDCLASS.

DATA go_local TYPE REF TO lcl_lokal.
DATA go_local2 TYPE REF TO lcl_lokal.

START-OF-SELECTION.
  CREATE OBJECT go_local.
  go_local->set_name( EXPORTING iv_name = 'Müller' ).
  create OBJECT go_local2.
  go_local2->set_name( EXPORTING iv_name = 'Maier' ).


  WRITE: / go_local->mv_name.
  WRITE: / go_local2->mv_name.

  ULINE.

*data r_int type REF TO i.
*create data r_int.
*r_int->* = 45.
*
*write r_int->*.
