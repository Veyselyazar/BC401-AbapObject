*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_11_instanzkonstruktor.
CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.
    METHODS set_attributes
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype.

  PRIVATE SECTION.
    DATA mv_name  TYPE string.
    DATA mv_planetype TYPE saplane-planetype.

ENDCLASS.
CLASS lcl_airplane IMPLEMENTATION.
  METHOD set_attributes.
    mv_name = iv_name.
    mv_planetype = iv_planetype.

  ENDMETHOD.

ENDCLASS.
* Hauptprogramm


DATA go_air TYPE REF TO lcl_airplane.
DATA gt_air LIKE TABLE OF go_air.


START-OF-SELECTION.
  CREATE OBJECT go_air.

  go_air->set_attributes(
    EXPORTING
      iv_name      = 'Hamburg'
      iv_planetype = 'A380-800' ).
  INSERT go_air INTO TABLE gt_air.
*******************************************
  CREATE OBJECT go_air.
  CALL METHOD go_air->set_attributes
    EXPORTING
      iv_name      = 'Berlin'
      iv_planetype = '747-400'.
  INSERT go_air INTO TABLE gt_air.
******************************************
  CREATE OBJECT go_air.
  go_air->set_attributes(
EXPORTING
  iv_name      = 'Heidelberg'
  iv_planetype = 'A320-200' ).

  INSERT go_air INTO TABLE gt_air.














  "! go_air1->display_n_o_airplanes( ).
