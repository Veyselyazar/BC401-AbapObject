class ZCL_CARGO_PLANE_00 definition
  public
  inheriting from ZCL_AIRPLANE_00
  final
  create private

  global friends ZCL_AIRPLANE_00 .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !IV_CARGO type SCPLANE-CARGOMAX
    exceptions
      WRONG_PLANETYPE .
  methods ANZEIGE_LADEGWEICHT .
  methods DISPLAY_CARGO .
  methods GET_CARGO
    returning
      value(RV_CARGO) type SCPLANE-CARGOMAX .

  methods DISPLAY_ATTRIBUTES
    redefinition .
protected section.
private section.

  data MV_CARGO type SCPLANE-CARGOMAX .
ENDCLASS.



CLASS ZCL_CARGO_PLANE_00 IMPLEMENTATION.


  method ANZEIGE_LADEGWEICHT.
  endmethod.


  METHOD constructor.
    super->constructor(
      EXPORTING
        iv_name           = iv_name
        iv_planetype      = iv_planetype    " Flugzeugtyp
      EXCEPTIONS
        wrong_planetype   = 1
        import_name_empty = 2
    ).
    IF sy-subrc <> 0.
      RAISE wrong_planetype.
    ELSE.
      mv_cargo = iv_cargo.
    ENDIF.
  ENDMETHOD.


  method DISPLAY_ATTRIBUTES.
   SUPER->DISPLAY_ATTRIBUTES( ).
   write: / 'Ladegewicht', at c_pos_1 mv_cargo.
  endmethod.


  method DISPLAY_CARGO.
    write: /  'Ladegewicht', at c_pos_1 mv_cargo LEFT-JUSTIFIED.
  endmethod.


  method GET_CARGO.
    rv_cargo = mv_cargo.
  endmethod.
ENDCLASS.
