*&---------------------------------------------------------------------*
*&  Include           ZBC401_00_CARRIER
*&---------------------------------------------------------------------*
CLASS lcl_airplane DEFINITION.
  PUBLIC SECTION.
    CLASS-METHODS class_constructor.
    METHODS constructor
      IMPORTING iv_name      TYPE string
                iv_planetype TYPE saplane-planetype
      RAISING   zcx_00_bc401_nk.
    METHODS display_attributes.
    CLASS-METHODS display_n_o_airplanes.
    CLASS-METHODS get_n_o_airplanes RETURNING VALUE(rv_count) TYPE i.
    CLASS-METHODS get_technical_attributes
      IMPORTING iv_planetype TYPE saplane-planetype
      EXPORTING ev_weight    TYPE saplane-weight
                ev_tankcap   TYPE saplane-tankcap
      RAISING   zcx_00_bc401_nk.
  PROTECTED SECTION.
    CONSTANTS c_pos_1 TYPE i VALUE 23.

  PRIVATE SECTION.
    TYPES ty_planetype TYPE TABLE OF saplane WITH NON-UNIQUE KEY planetype.

    DATA: mv_name      TYPE string,
          mv_planetype TYPE saplane-planetype,
          mv_weight    TYPE saplane-weight,
          mv_tankcap   TYPE saplane-tankcap.

    CLASS-DATA gv_n_o_airplanes TYPE i.
    CLASS-DATA gt_planetypes TYPE ty_planetype.


ENDCLASS.
CLASS lcl_airplane IMPLEMENTATION.


  METHOD class_constructor.
    SELECT * FROM saplane INTO TABLE gt_planetypes.
  ENDMETHOD.
  METHOD constructor.
    DATA lo_err_tech TYPE REF TO cx_root.
    DATA ls_saplane TYPE saplane.
    IF iv_name IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk
        EXPORTING
          textid    = zcx_00_bc401_nk=>planetype_empty
          planetype = iv_planetype.
    ENDIF.

* Datenprüfung in Delegationsmethode get_technical_attributes
    TRY.
        CALL METHOD get_technical_attributes
          EXPORTING
            iv_planetype = iv_planetype
          IMPORTING
            ev_weight    = mv_weight
            ev_tankcap   = mv_tankcap.

        mv_name = iv_name.
        mv_planetype = iv_planetype.
        ADD 1 TO gv_n_o_airplanes.
      CATCH zcx_00_bc401_nk INTO lo_err_tech.
        RAISE EXCEPTION TYPE zcx_00_bc401_nk
          EXPORTING
            textid   = zcx_00_bc401_nk=>error_constructor
            previous = lo_err_tech.
    ENDTRY.

  ENDMETHOD.
  METHOD display_attributes.
    WRITE: / icon_ws_plane AS ICON,
           / 'Flugzeugname'(fzn), AT c_pos_1 mv_name,
           / 'Flugzeugtyp'(fzt), AT c_pos_1 mv_planetype,
           / 'Gewicht'(gew), AT c_pos_1 mv_weight LEFT-JUSTIFIED,
           / 'Tankkapazität'(tkp), AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.
  ENDMETHOD.
  METHOD display_n_o_airplanes.
    WRITE: / 'Anzahl der Flugzeuge'(afl),
            AT c_pos_1 gv_n_o_airplanes LEFT-JUSTIFIED.
  ENDMETHOD.

  METHOD get_n_o_airplanes.
    rv_count = gv_n_o_airplanes.
  ENDMETHOD.

  METHOD get_technical_attributes.
    DATA ls_saplane TYPE saplane.
    READ TABLE gt_planetypes INTO ls_saplane
     WITH KEY planetype = iv_planetype.
    IF sy-subrc = 0.
      ev_weight = ls_saplane-weight.
      ev_tankcap = ls_saplane-tankcap.
    ELSE.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk
        EXPORTING
          textid    = zcx_00_bc401_nk=>wrong_planetype
          planetype = iv_planetype.
    ENDIF.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_passenger_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.
    METHODS constructor IMPORTING iv_name TYPE string iv_planetype TYPE saplane-planetype
                                  iv_seats TYPE i
                        RAISING zcx_00_bc401_nk.
    METHODS display_attributes REDEFINITION.
  PRIVATE SECTION.
    DATA mv_seats TYPE i.
ENDCLASS.
CLASS lcl_passenger_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name         = iv_name
        iv_planetype    =  iv_planetype ).
    mv_seats = iv_seats.

  ENDMETHOD.
  METHOD display_attributes.
    super->display_attributes( ).
    WRITE: / 'Anzahl Plätze', AT c_pos_1 mv_seats LEFT-JUSTIFIED.

  ENDMETHOD.
ENDCLASS.

CLASS lcl_cargo_plane DEFINITION INHERITING FROM lcl_airplane.
  PUBLIC SECTION.
    METHODS constructor IMPORTING cargo_iv_name      TYPE string
                                  cargo_iv_planetype TYPE saplane-planetype
                                  iv_cargo           TYPE scplane-cargomax
                        RAISING   zcx_00_bc401_nk.
    METHODS display_attributes REDEFINITION.
    METHODS get_cargo RETURNING VALUE(rv_cargo) TYPE scplane-cargomax.

  PROTECTED SECTION.
    DATA mv_cargo TYPE scplane-cargomax.
ENDCLASS.
CLASS lcl_cargo_plane IMPLEMENTATION.
  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name         = cargo_iv_name
        iv_planetype    =  cargo_iv_planetype  ).

    mv_cargo = iv_cargo.

  ENDMETHOD.
  METHOD display_attributes.
    super->display_attributes( ).
    WRITE: / 'Max. Ladegewicht', AT c_pos_1 mv_cargo LEFT-JUSTIFIED.
  ENDMETHOD.
  METHOD get_cargo.
    rv_cargo = mv_cargo.
  ENDMETHOD.
ENDCLASS.


CLASS lcl_carrier DEFINITION.

  PUBLIC SECTION.
    INTERFACES lif_partner.
    METHODS:
      constructor IMPORTING iv_name TYPE string,
      add_airplane IMPORTING io_plane TYPE REF TO lcl_airplane,
      display_attributes.

    DATA mv_name      TYPE string READ-ONLY.
  PRIVATE SECTION.
    METHODS get_max_cargo RETURNING VALUE(rv_max_cargo) TYPE scplane-cargomax.
    METHODS  display_airplanes.

    DATA mt_airplanes TYPE TABLE OF REF TO lcl_airplane.

ENDCLASS.                    "lcl_carrier DEFINITION

*---------------------------------------------------------------------*
*       CLASS lcl_carrier IMPLEMENTATION
*---------------------------------------------------------------------*
CLASS lcl_carrier IMPLEMENTATION.

  METHOD constructor.
    "Formalparamter    Aktualparameter
    mv_name       =    iv_name.
  ENDMETHOD.                    "constructor

  METHOD display_attributes.

    SKIP 2.
    WRITE: icon_flight AS ICON,
           mv_name.
    ULINE.
    ULINE.
    display_airplanes( ).
    ULINE.
    DATA(lv_cargo_max) = me->get_max_cargo( ).
    IF lv_cargo_max IS NOT INITIAL.
      WRITE: / 'Höchstes Ladegwicht aller Frachtflugzeuge der', mv_name, 'ist', lv_cargo_max LEFT-JUSTIFIED.
    ENDIF.
  ENDMETHOD.

  METHOD display_airplanes.
    DATA lo_airplane TYPE REF TO lcl_airplane.
    LOOP AT mt_airplanes INTO lo_airplane.
      lo_airplane->display_attributes( ).
    ENDLOOP.
  ENDMETHOD.                    "display_attributes

  METHOD add_airplane.
    APPEND io_plane TO mt_airplanes.
  ENDMETHOD.
  METHOD get_max_cargo.
    DATA lo_airplane TYPE REF TO lcl_airplane.
    DATA lo_cargo TYPE REF TO lcl_cargo_plane.
    DATA lv_cargo TYPE scplane-cargomax.
    LOOP AT mt_airplanes INTO lo_airplane.
      IF lo_airplane IS INSTANCE OF lcl_cargo_plane.
        lo_cargo ?= lo_airplane.
        lv_cargo = lo_cargo->get_cargo( ).
        IF lv_cargo > rv_max_cargo.
          rv_max_cargo = lv_cargo.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
  METHOD lif_partner~display_partner.
*    uline.
*    write: 'Fluggesellschaft aus dem Interface heraus', mv_name.
    CALL METHOD display_attributes.
  ENDMETHOD.
ENDCLASS.
