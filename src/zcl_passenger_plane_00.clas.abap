class ZCL_PASSENGER_PLANE_00 definition
  public
  inheriting from ZCL_AIRPLANE_00
  create private

  global friends ZCL_AIRPLANE_00
                 ZCL_MITA_00 .

public section.

  methods CONSTRUCTOR
    importing
      !IV_NAME type STRING
      !IV_PLANETYPE type SAPLANE-PLANETYPE
      !IV_SEATS type INT4
    exceptions
      WRONG_PLANETYPE .
  methods DISPLAY_PASSAGIERE .

  methods DISPLAY_ATTRIBUTES
    redefinition .
protected section.
private section.

  data MV_SEATS type INT4 .
ENDCLASS.



CLASS ZCL_PASSENGER_PLANE_00 IMPLEMENTATION.


  method CONSTRUCTOR.
    super->constructor(
      EXPORTING
        iv_name           = iv_name
        iv_planetype      =  iv_planetype   " Flugzeugtyp
      EXCEPTIONS
        wrong_planetype   = 1
        import_name_empty = 2
    ).
    IF sy-subrc <> 0.
      raise wrong_planetype.
    else.
      mv_seats = iv_seats.
    ENDIF.
  endmethod.


  method DISPLAY_ATTRIBUTES.
 SUPER->DISPLAY_ATTRIBUTES( ).
 write: / 'Maximale Plätze', at c_pos_1 mv_seats LEFT-JUSTIFIED.
  endmethod.


  method DISPLAY_PASSAGIERE.
    write: / 'Anzahl Passagiere', at c_pos_1 mv_seats LEFT-JUSTIFIED.
  endmethod.
ENDCLASS.
