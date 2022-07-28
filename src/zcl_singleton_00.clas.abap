class ZCL_SINGLETON_00 definition
  public
  final
  create public .

public section.

  class-data GO_SINGLE type ref to ZCL_SINGLETON_00 read-only .

  class-methods CLASS_CONSTRUCTOR .
  class-methods GET_SINGLE
    returning
      value(RO_SINGLE) type ref to ZCL_SINGLETON_00 .
protected section.
private section.

  class-data:
    GT_SCARR type  table of SCARR .
ENDCLASS.



CLASS ZCL_SINGLETON_00 IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
    create object go_single.
    select * from scarr into table gt_scarr.
  endmethod.


  method GET_SINGLE.
    ro_single = go_single.
  endmethod.
ENDCLASS.
