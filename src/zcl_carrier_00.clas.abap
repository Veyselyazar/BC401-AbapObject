class ZCL_CARRIER_00 definition
  public
  final
  create public .

public section.

  data MV_NAME type STRING read-only .

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING .
  methods ADD_AIRPLANE
    importing
      !IO_PLANE type ref to ZCL_AIRPLANE_00 .
  methods DISPLAY_ATTRIBUTES .
protected section.
private section.

  data:
    MT_AIRPLANES type table of ref to ZCL_AIRPLANE_00 .

  methods DISPLAY_AIRPLANES .
  methods GET_CARGO_MAX
    returning
      value(RV_CARGO_MAX) type SCPLANE-CARGOMAX .
ENDCLASS.



CLASS ZCL_CARRIER_00 IMPLEMENTATION.


  METHOD add_airplane.
   " APPEND io_plane TO mt_airplanes.
    INSERT io_plane INTO TABLE mt_airplanes.
  ENDMETHOD.


  method CONSTRUCTOR.
    mv_name = iv_name.
  endmethod.


  method DISPLAY_AIRPLANES.
*    data lo_airplane1 type REF TO ZCL_AIRPLANE_00.
*    data lo_airplane2 like line of MT_AIRPLANES.
    loop at MT_AIRPLANES into data(lo_airplane).
        lo_airplane->display_attributes( ).
    endloop.
  endmethod.


  METHOD display_attributes.
    SKIP .
    SKIP.
    WRITE: / icon_flight AS ICON,
             'Fluggesellschaft: ', mv_name.
    ULINE.
    ULINE.
    CALL METHOD display_airplanes.
    DATA(lv_cargo_max) = get_cargo_max( ).
    uline.
    write: / 'Maximale Ladekapazität des größten Frachtflugzeuges', lv_cargo_max.
  ENDMETHOD.


  METHOD get_cargo_max.
    DATA lo_cargo TYPE REF TO zcl_cargo_plane_00.

    LOOP AT mt_airplanes INTO DATA(lo_airplane).
      IF lo_airplane IS INSTANCE OF zcl_cargo_plane_00.
        lo_cargo ?= lo_airplane.
        DATA(lv_cargo) = lo_cargo->get_cargo( ).
        IF lv_cargo > rv_cargo_max.
          rv_cargo_max = lv_cargo.
        ENDIF.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
