*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_00_main_carrier_global.
* Hauptprogramm


DATA: gv_name      TYPE string,
      gv_carrier   TYPE string,
      gv_planetype TYPE saplane-planetype,
      gv_cargo     TYPE s_plan_car.
DATA gs_saplane TYPE saplane.

DATA: "go_air     TYPE REF TO zcl_airplane_00,
  "gt_air     LIKE TABLE OF go_air,
  go_pass    TYPE REF TO zcl_passenger_plane_00,
  go_cargo   TYPE REF TO zcl_cargo_plane_00,
  go_carrier TYPE REF TO zcl_carrier_00.
DATA gt_carrier LIKE TABLE OF go_carrier.
DATA go_handler TYPE REF TO zcl_handler_airplane.

START-OF-SELECTION.
  CREATE OBJECT go_handler.
  SET HANDLER go_handler->on_airplane_erzeugt FOR ALL INSTANCES ACTIVATION 'X' .
 " SET HANDLER go_handler->on_airplane_erzeugt FOR ALL INSTANCES ACTIVATION ' '.


  SELECT * FROM saplane INTO gs_saplane WHERE zzname <> space.
    gv_name = gs_saplane-zzname.  "String aus Text40
    gv_planetype = gs_saplane-planetype.
    gv_cargo = gs_saplane-zzcargo.  "SCPLANE-CARGOMAX aus Int4
    gv_carrier = gs_saplane-zzcarrier. "String aus Text40
    IF gs_saplane-zzcarrier IS INITIAL.
      gv_carrier = 'nicht zugeordnet'(car).
    ENDIF.
    READ TABLE gt_carrier INTO go_carrier
      WITH KEY table_line->mv_name = gv_carrier.
    IF sy-subrc <> 0.
      CREATE OBJECT go_carrier EXPORTING iv_name = gv_carrier.
      APPEND go_carrier TO gt_carrier.
    ENDIF.


    DATA(gv_laenge) = strlen( gs_saplane-planetype ) - 1.
    IF gs_saplane-planetype+gv_laenge = 'F'.
      " Objekt der Klasse lcl_cargo_plane
      CREATE OBJECT go_cargo
        EXPORTING
          iv_name         = gv_name
          iv_planetype    = gv_planetype
          iv_cargo        = gv_cargo
        EXCEPTIONS
          wrong_planetype = 1.
      IF sy-subrc = 0.
        go_carrier->add_airplane( go_cargo ).

      ENDIF.
    ELSE.
      "Objekt der Klasse lcl_passenger_plane
      CREATE OBJECT go_pass
        EXPORTING
          iv_name         = gv_name
          iv_planetype    = gv_planetype
          iv_seats        = gs_saplane-seatsmax
        EXCEPTIONS
          wrong_planetype = 1.
      IF sy-subrc = 0.
        go_carrier->add_airplane( go_pass ).

      ENDIF.

    ENDIF.

  ENDSELECT.
**********************************************************************
  SORT gt_carrier BY table_line->mv_name DESCENDING.
  LOOP AT gt_carrier INTO go_carrier.
    go_carrier->display_attributes( ).
  ENDLOOP.

*  LOOP AT gt_air INTO go_air.
*    go_air->display_attributes( ).
*
**    TRY.
**        go_cargo ?= go_air.  " Down-Casting Dynamische Typen: Cargo, Passenger
**        go_cargo->display_cargo( ).
**      CATCH cx_sy_move_cast_error.
**    ENDTRY.
**    TRY.
**        go_pass ?= go_air.  " Down-Casting Dynamische Typen: Cargo, Passenger
**        go_pass->display_passagiere( ).
**      CATCH cx_sy_move_cast_error.
**    ENDTRY.
*
*    IF go_air IS INSTANCE OF zcl_cargo_plane_00.
*      "go_cargo ?= go_air.
*      move go_air ?to go_cargo.
*      go_cargo->display_cargo( ).
*    ELSEIF go_air IS INSTANCE OF zcl_passenger_plane_00.
*      go_pass ?= go_air.
*      go_pass->display_passagiere( ).
*    else.
*      message 'Irgendein Objekt einer unbekannten Unterklasse oder aus der Oberklasse' type 'I'.
*    ENDIF.
*
*  ENDLOOP.
