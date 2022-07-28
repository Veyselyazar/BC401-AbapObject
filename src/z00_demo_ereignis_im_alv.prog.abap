*&---------------------------------------------------------------------*
*& Report Z00_DEMO_ALV_OHNE_FUNKTION
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_demo_ereignis_im_alv.

CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    METHODS on_double_click
      FOR EVENT double_click
                OF  cl_gui_alv_grid
      IMPORTING es_row_no e_column.
    methods on_toolbar
       for EVENT toolbar
       of  cl_gui_alv_grid
       IMPORTING e_object.
ENDCLASS.
CLASS lcl_handler IMPLEMENTATION.
  METHOD on_double_click.
    MESSAGE `Zeile: ` && es_row_no-row_id &&
            ` Spalte: ` && e_column-fieldname
            TYPE 'I'.

  ENDMETHOD.
  method on_toolbar.

  endmethod.

ENDCLASS.


DATA go_alv TYPE REF TO cl_gui_alv_grid.
DATA go_handler TYPE REF TO lcl_handler.
DATA gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.
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

  CREATE OBJECT go_handler.
  SET HANDLER: go_handler->on_double_click FOR ALL INSTANCES,
               go_handler->on_toolbar FOR ALL INSTANCES.


  go_alv->set_table_for_first_display(
    EXPORTING
      i_structure_name              = 'SCARR'
    CHANGING
      it_outtab                     = gt_scarr ).


ENDMODULE.
