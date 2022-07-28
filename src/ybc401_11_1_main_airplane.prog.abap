*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_11_main.
CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.
    METHODS set_attributes
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype.
    METHODS display_attributes.
    CLASS-METHODS display_n_o_airplanes.
    DATA mv_name      TYPE string READ-ONLY.
  PRIVATE SECTION.
    CLASS-METHODS display_text.
    CONSTANTS c_pos_1 TYPE i VALUE 23.
    "data mv_name type string.
    DATA:  mv_planetype TYPE saplane-planetype.
    CLASS-DATA gv_n_o_airplanes TYPE i.
ENDCLASS.
CLASS lcl_airplane IMPLEMENTATION.
  METHOD set_attributes.
    mv_name = iv_name.
    mv_planetype = iv_planetype.
    ADD 1 TO gv_n_o_airplanes.
  ENDMETHOD.
  METHOD display_attributes.
    WRITE: / icon_ws_plane AS ICON,
           / 'Flugzeugname'(fzn), AT c_pos_1 mv_name,
           / 'Flugzeugtyp'(fzt), AT c_pos_1 mv_planetype.
  ENDMETHOD.
  METHOD display_n_o_airplanes.
    WRITE: / 'Anzahl der Flugzeuge'(afl),
            AT c_pos_1 gv_n_o_airplanes LEFT-JUSTIFIED.
    CALL METHOD display_text.
*    CALL METHOD lcl_airplane=>display_text.
*    display_text( ).
*    lcl_airplane=>display_text( ).
  ENDMETHOD.
  METHOD display_text.
    MESSAGE 'text-Methode' TYPE 'I'.
  ENDMETHOD.
ENDCLASS.
* Hauptprogramm


DATA go_air TYPE REF TO lcl_airplane.
DATA gt_air LIKE TABLE OF go_air.


START-OF-SELECTION.
  lcl_airplane=>display_n_o_airplanes( ).
  CREATE OBJECT go_air.

  go_air->set_attributes(
    EXPORTING
      iv_name      = 'Hamburg'
      iv_planetype = 'A380-800'
  ).
  " go_air1->display_attributes( ).
  INSERT go_air INTO TABLE gt_air.
*******************************************
  CREATE OBJECT go_air.
  CALL METHOD go_air->set_attributes
    EXPORTING
      iv_name      = 'Berlin'
      iv_planetype = '747-400'.
  "go_air2->display_attributes( ).
  INSERT go_air INTO TABLE gt_air.
******************************************
  CREATE OBJECT go_air.
  go_air->set_attributes(
EXPORTING
  iv_name      = 'Heidelberg'
  iv_planetype = 'A320-200'
).
  "go_air2->display_attributes( ).
  INSERT go_air INTO TABLE gt_air.
  "SORT gt_air BY table_line ASCENDING.
  LOOP AT gt_air INTO go_air.
    CALL METHOD go_air->display_attributes.
  ENDLOOP.
  ULINE.


  go_air->display_n_o_airplanes( ).

*  READ TABLE gt_air INTO go_air
*    WITH KEY table_line->mv_name = 'Hamburg'.
*
*  IF sy-subrc = 0.
*    go_air->display_attributes( ).
*  ELSE.
*    MESSAGE 'Name existiert nicht als Objekt' TYPE 'I'.
*  ENDIF.












  "! go_air1->display_n_o_airplanes( ).
