*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_00_main.
INCLUDE zbc401_00_agency.
INCLUDE zbc401_00_carrier.


* Hauptprogramm


DATA: gv_name      TYPE string,
      gv_planetype TYPE saplane-planetype,
      gv_cargo     TYPE s_plan_car,
      gv_carrier   TYPE string.
DATA gs_saplane TYPE saplane.

DATA: "go_air     TYPE REF TO lcl_airplane,
  " gt_air   LIKE TABLE OF go_air,
  go_pass    TYPE REF TO lcl_passenger_plane,
  go_cargo   TYPE REF TO lcl_cargo_plane,
  go_carrier TYPE REF TO lcl_carrier.

DATA gt_carrier TYPE TABLE OF REF TO lcl_carrier.
DATA go_travel TYPE REF TO lcl_travel_agency.

START-OF-SELECTION.
  CREATE OBJECT go_travel EXPORTING iv_name = 'Never Come Back Traveling'.

*  lcl_airplane=>display_n_o_airplanes( ).

  SELECT * FROM saplane INTO gs_saplane WHERE zzname <> space.
    gv_name = gs_saplane-zzname.
    "CLEAR gv_name.
    gv_planetype = gs_saplane-planetype .
    gv_planetype = 'X' && gv_planetype.
    gv_cargo = gs_saplane-zzcargo.
    gv_carrier = gs_saplane-zzcarrier.
    DATA(gv_laenge) = strlen( gs_saplane-planetype ) - 1.

    IF gs_saplane-zzcarrier IS INITIAL.
      gv_carrier = 'Y-Nicht zugeordnetete Flugzeuge'.
    ENDIF.
    READ TABLE gt_carrier INTO go_carrier
      WITH KEY table_line->mv_name = gv_carrier.
    IF sy-subrc = 4.
      CREATE OBJECT go_carrier EXPORTING iv_name = gv_carrier.
      APPEND go_carrier TO gt_carrier.
      go_travel->add_partner( go_carrier ).
    ENDIF.

    TRY.
        IF gs_saplane-planetype+gv_laenge = 'F'.
          " Objekt der Klasse lcl_cargo_plane
          CREATE OBJECT go_cargo
            EXPORTING
              cargo_iv_name      = gv_name
              cargo_iv_planetype = gv_planetype
              iv_cargo           = gv_cargo.

          go_carrier->add_airplane( go_cargo ).

        ELSE.
          "Objekt der Klasse lcl_passenger_plane
          CREATE OBJECT go_pass
            EXPORTING
              iv_name      = gv_name
              iv_planetype = gv_planetype
              iv_seats     = gs_saplane-seatsmax.

          go_carrier->add_airplane( go_pass ).


        ENDIF.
      CATCH zcx_00_bc401_nk INTO DATA(go_error).
        WRITE: / go_error->get_text( ) .  " letzte Ausnahme (Constructor
        WRITE: / go_error->previous->get_text( ) . " vorherige Ausnahme (Original aus Get..)
        "   WRITE: / go_error->previous->previous->get_text( ) . " vorherige Ausnahme (Original aus Get..)

    ENDTRY.
  ENDSELECT.

  DATA go_partner TYPE REF TO lif_partner.
*

  go_travel->display_attributes( ).

*  SORT gt_carrier BY table_line->mv_name ASCENDING.
*  LOOP AT gt_carrier INTO go_carrier.
*    go_carrier->display_attributes( ).
*    NEW-PAGE.
*    " go_carrier->lif_partner~display_partner( ).
*  ENDLOOP.
















  "! go_air1->display_n_o_airplanes( ).
