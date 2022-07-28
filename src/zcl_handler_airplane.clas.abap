class ZCL_HANDLER_AIRPLANE definition
  public
  final
  create public .

public section.

  methods ON_AIRPLANE_ERZEUGT
    for event AIRPLANE_ERZEUGT of ZCL_AIRPLANE_00
    importing
      !SENDER
      !EO_AIRPLANE .
protected section.
private section.

  class-data GT_PASSENGER type table of  ref to ZCL_PASSENGER_PLANE_00 .
ENDCLASS.



CLASS ZCL_HANDLER_AIRPLANE IMPLEMENTATION.


  METHOD on_airplane_erzeugt.
    DATA lo_pass TYPE REF TO zcl_passenger_plane_00.
    TRY.
        lo_pass ?= eo_airplane.
        APPEND lo_pass TO gt_passenger.
      CATCH cx_sy_move_cast_error.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
