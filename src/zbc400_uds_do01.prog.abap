*----------------------------------------------------------------------*
***INCLUDE MBC400_UDS_DO01 .
*----------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*&      Module  init_control_processing_0200  OUTPUT
*&---------------------------------------------------------------------*
MODULE init_control_processing_0200 OUTPUT.

  IF go_container IS INITIAL.

    CREATE OBJECT go_container
      EXPORTING
        container_name    = 'CONTROL_AREA_FLIGHTS'.

    CREATE OBJECT go_alv_grid
      EXPORTING
        i_parent          = go_container.

    CALL METHOD go_alv_grid->set_table_for_first_display
      EXPORTING
        i_structure_name = 'BC400_S_FLIGHT'
      CHANGING
        it_outtab        =  gt_flights.
  ELSE.
    CALL METHOD go_alv_grid->refresh_table_display.
  ENDIF.
ENDMODULE.                 " init_control_processing_0200  OUTPUT
