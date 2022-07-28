class ZCL_AIRPLANE_00 definition
  public
  create public

  global friends ZCL_MITA_00
                 ZCL_PASSENGER_PLANE_00 .

public section.

  data MV_NAME type STRING read-only .

  events AIRPLANE_ERZEUGT
    exporting
      value(EO_AIRPLANE) type ref to ZCL_AIRPLANE_00 optional .
  events AIRPLANE_ANGEZEIGT .
  class-events CARGO_ERZEUGT .
  class-events PASSENGER_ERZEUGT .

  class-methods CLASS_CONSTRUCTOR .
  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
    exceptions
      WRONG_PLANETYPE
      IMPORT_NAME_EMPTY .
  methods DISPLAY_ATTRIBUTES .
  class-methods DISPLAY_N_O_AIRPLANES .
  class-methods GET_N_O_AIRPLANES
    returning
      value(RV_COUNT) type INT4 .
  methods ADD_REFERENCE_INTO_TABLE
    importing
      !IO_REFERENZ type ref to ZCL_AIRPLANE_00 .
  class-methods DISPLAY_ALLE_INSTANZEN .
  class-methods GET_REF_AIRPLANE
    importing
      !IV_NAME type STRING
    returning
      value(RO_AIRPLANE) type ref to ZCL_AIRPLANE_00 .
  class-methods FACTORY_CARGO
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !IV_CARGO type SCPLANE-CARGOMAX
    returning
      value(RO_CARGO) type ref to ZCL_CARGO_PLANE_00
    raising
      ZCX_00_BC401_NK .
  class-methods FACTORY_PASS
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !IV_SEATS type INT4
    returning
      value(RO_PASS) type ref to ZCL_PASSENGER_PLANE_00
    raising
      ZCX_00_BC401_NK .
  class-methods FACTORY
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !IV_SEATS type INT4 optional
      !IV_CARGO type SCPLANE-CARGOMAX optional
    returning
      value(RO_PASS) type ref to ZCL_PASSENGER_PLANE_00
    raising
      ZCX_00_BC401_NK .
  class-methods DISPLAY_ALL_PLANES .
protected section.

  data MV_PLANETYPE type SAPLANE-PLANETYPE .
  constants C_POS_1 type INT4 value 20 ##NO_TEXT.
private section.

  class-data GV_N_O_AIRPLANES type INT4 .
  data MV_WEIGHT type SAPLANE-WEIGHT .
  data MV_TANKCAP type SAPLANE-TANKCAP .
  class-data GT_PLANETYPES type TY_PLANETYPES .
  class-data MO_AIR type ref to ZCL_AIRPLANE_00 .
  class-data:
    GT_AIR type table of ref to ZCL_AIRPLANE_00 .

  class-methods GET_TECHNICAL_ATTRIBUTES
    importing
      !IV_PLANETYPE type SAPLANE-PLANETYPE
    exporting
      !EV_WEIGHT type SAPLANE-WEIGHT
      !EV_TANKCAP type SAPLANE-TANKCAP
    exceptions
      WRONG_PLANETYPE_GTA .
ENDCLASS.



CLASS ZCL_AIRPLANE_00 IMPLEMENTATION.


  method ADD_REFERENCE_INTO_TABLE.
    append io_referenz to gt_air.
  endmethod.


  method CLASS_CONSTRUCTOR.
    select * from saplane into table gt_planetypes.
  endmethod.


  METHOD constructor.
    IF iv_name IS INITIAL.
      RAISE import_name_empty.
    ENDIF.

    zcl_airplane_00=>get_technical_attributes(
      EXPORTING
        iv_planetype        = iv_planetype
      IMPORTING
        ev_weight           = mv_weight
        ev_tankcap          = mv_tankcap
      EXCEPTIONS
        wrong_planetype_gta = 1 ).
    IF sy-subrc <> 0.
      RAISE wrong_planetype.
    ELSE.
      MOVE: iv_name TO mv_name,
            iv_planetype TO mv_planetype.
      ADD 1 TO gv_n_o_airplanes. "Statisches Attribut wird um 1 erhöht
      RAISE EVENT airplane_erzeugt EXPORTING  eo_airplane = me  .
    ENDIF.
  ENDMETHOD.


  METHOD display_alle_instanzen.
    sort gt_air by table_line->mv_name.
    LOOP AT gt_air INTO mo_air.
      mo_air->display_attributes( ).
    ENDLOOP.
  ENDMETHOD.


  method DISPLAY_ALL_PLANES.
    loop at gt_air into data(lo_air).
      lo_air->display_attributes( ).
    ENDLOOP.
  endmethod.


  METHOD display_attributes.
    WRITE: / icon_ws_plane AS ICON,
           / 'Flugneugname', AT  c_pos_1 mv_name,
           / 'Flugzeugtyp',  AT  c_pos_1 mv_planetype,
           / 'Gewicht', AT c_pos_1 mv_weight LEFT-JUSTIFIED,
           / 'Tankkapazität', AT c_pos_1 mv_tankcap LEFT-JUSTIFIED.
  ENDMETHOD.


  method DISPLAY_N_O_AIRPLANES.
    write: / 'Anzahl Airplanes', at c_pos_1 gv_n_o_airplanes.
  endmethod.


  METHOD factory.
    DATA lo_pass TYPE REF TO zcl_passenger_plane_00.
    DATA lo_cargo TYPE REF TO zcl_cargo_plane_00.
    DATA lo_air TYPE REF TO zcl_airplane_00.
    DATA lv_laenge TYPE i.

    IF iv_name IS INITIAL OR iv_planetype IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk.
    ENDIF.

    READ TABLE gt_air INTO lo_air
      WITH KEY table_line->mv_name = iv_name.
    IF sy-subrc = 4.
      lv_laenge = strlen( iv_planetype ) - 1.

      IF iv_planetype+lv_laenge = 'F'.
        CREATE OBJECT lo_cargo
          EXPORTING
            iv_name      = iv_name
            iv_planetype = iv_planetype
            iv_cargo     = iv_cargo.
        INSERT lo_cargo INTO TABLE gt_air.
        raise event cargo_erzeugt.
      ELSE.
        CREATE OBJECT lo_pass
          EXPORTING
            iv_name      = iv_name
            iv_planetype = iv_planetype
            iv_seats     = iv_seats.
        INSERT lo_pass INTO TABLE gt_air.
        raise EVENT passenger_erzeugt.
      ENDIF.
    ENDIF.
    ro_pass = lo_pass.
  ENDMETHOD.


  METHOD factory_cargo.
    DATA lo_cargo TYPE REF TO zcl_cargo_plane_00.
    DATA lo_air TYPE REF TO zcl_airplane_00.

    IF iv_name IS INITIAL OR iv_planetype IS INITIAL OR iv_cargo IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk.
    ENDIF.

    READ TABLE gt_air INTO lo_air
      WITH KEY table_line->mv_name = iv_name.
    IF sy-subrc = 4.
      CREATE OBJECT lo_cargo
        EXPORTING
          iv_name      = iv_name
          iv_planetype = iv_planetype
          iv_cargo     = iv_cargo.
      INSERT lo_cargo INTO TABLE gt_air.
    ENDIF.
    ro_cargo = lo_cargo.
  ENDMETHOD.


  METHOD factory_pass.
    DATA lo_pass TYPE REF TO zcl_passenger_plane_00.
    DATA lo_air TYPE REF TO zcl_airplane_00.

    IF iv_name IS INITIAL OR iv_planetype IS INITIAL OR iv_seats IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk.
    ENDIF.

    READ TABLE gt_air INTO lo_air
      WITH KEY table_line->mv_name = iv_name.
    IF sy-subrc = 4.
      CREATE OBJECT lo_pass
        EXPORTING
          iv_name      = iv_name
          iv_planetype = iv_planetype
          iv_seats     = iv_seats.
      INSERT lo_pass INTO TABLE gt_air.
    ENDIF.
    ro_pass = lo_pass.
  ENDMETHOD.


  method GET_N_O_AIRPLANES.
    rv_count  = gv_n_o_airplanes.
  endmethod.


  METHOD get_ref_airplane.
    READ TABLE gt_air INTO DATA(lo_air)
      WITH KEY table_line->mv_name = iv_name.

    IF sy-subrc = 0.
      ro_airplane = lo_air.
    ENDIF.
  ENDMETHOD.


  METHOD get_technical_attributes.
    DATA ls_saplane TYPE saplane.
    READ TABLE gt_planetypes INTO ls_saplane
    WITH KEY planetype = iv_planetype.
    IF sy-subrc = 0.
      ev_weight = ls_saplane-weight.
      ev_tankcap = ls_saplane-tankcap.
    ELSE.
      RAISE wrong_planetype_gta.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
