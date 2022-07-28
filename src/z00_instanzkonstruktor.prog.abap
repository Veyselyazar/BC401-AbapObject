*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_instanzkonstruktor.
CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.
    EVENTS flugzeug_erzeugt.
    METHODS constructor
      IMPORTING  iv_name      TYPE string
                 iv_planetype TYPE saplane-planetype
      EXCEPTIONS
                 parameter_leer
                 wrong_planetype.

  PRIVATE SECTION.
    DATA mv_name  TYPE string.
    DATA mv_planetype TYPE saplane-planetype.
    DATA mv_weight TYPE saplane-weight.
    DATA mv_tankcap TYPE saplane-tankcap.

ENDCLASS.
CLASS lcl_airplane IMPLEMENTATION.
  METHOD constructor.
    " DATA ls_saplane TYPE saplane.
    IF iv_name IS NOT INITIAL AND iv_planetype IS NOT INITIAL.

      SELECT SINGLE weight tankcap FROM saplane
        INTO (mv_weight, mv_tankcap)
        WHERE planetype = iv_planetype.
      IF sy-subrc = 0.
        mv_name = iv_name.
        mv_planetype = iv_planetype.
      ELSE.
        RAISE wrong_planetype.
      ENDIF.
    ELSE.
      RAISE parameter_leer.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
* Hauptprogramm


DATA go_air TYPE REF TO lcl_airplane.
DATA gt_air LIKE TABLE OF go_air.


START-OF-SELECTION.
  CREATE OBJECT go_air   "Methode Constructor wird automatisch aufgerufen
    EXPORTING
      iv_name         = 'Berlin'
      iv_planetype    = '747-400'
    EXCEPTIONS
      parameter_leer  = 1
      wrong_planetype = 2.

  IF sy-subrc = 0.
    INSERT go_air INTO TABLE gt_air.
  ENDIF.


* Alternative Syntax zur Erzeugung eines Objektes
  DATA(go_air2) = NEW lcl_airplane(
                  iv_name = 'Hamburg'
                  iv_planetype = 'A380-800' ).


  go_air2 = NEW #(  iv_name = 'Hamburg'
                    iv_planetype = 'A380-800' ).
  BREAK-POINT.















  "! go_air1->display_n_o_airplanes( ).
