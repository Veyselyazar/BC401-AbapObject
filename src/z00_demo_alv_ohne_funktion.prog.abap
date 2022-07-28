*&---------------------------------------------------------------------*
*& Report Z00_DEMO_ALV_OHNE_FUNKTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_alv_ohne_funktion.


DATA go_alv TYPE REF TO cl_gui_alv_grid.
DATA gt_scarr TYPE TABLE OF scarr.
SELECT * FROM scarr INTO TABLE gt_scarr.

CALL SCREEN 100.
*&---------------------------------------------------------------------*
*&      Module  CREATE_ALV  OUTPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE create_alv OUTPUT.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = cl_gui_custom_container=>screen0.


  go_alv->set_table_for_first_display(
    EXPORTING
      i_structure_name              = 'SCARR'
    CHANGING
      it_outtab                     = gt_scarr ).


ENDMODULE.
