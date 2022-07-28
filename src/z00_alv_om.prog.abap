*&---------------------------------------------------------------------*
*& Report Z00_ALV_OM
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_alv_om.

DATA gt_scarr TYPE TABLE OF scarr.
DATA go_alv TYPE REF TO cl_salv_table.
DATA go_func TYPE REF TO cl_salv_functions.

SELECT * FROM scarr INTO TABLE gt_scarr.


cl_salv_table=>factory(
*   EXPORTING
*     list_display   = IF_SALV_C_BOOL_SAP=>FALSE
  IMPORTING
    r_salv_table   = go_alv
  CHANGING
    t_table        = gt_scarr
       ).

go_func = go_alv->get_functions( ).
go_func->set_all( ).

go_alv->display( ).
