*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_00_main_lobale_klasse.


DATA: gv_name  TYPE string,
      gv_cargo TYPE scplane-cargomax.

DATA gs_saplane TYPE saplane.

START-OF-SELECTION.
  TRY.
      SELECT * FROM saplane INTO gs_saplane WHERE zzname <> space ORDER BY zzcarrier DESCENDING .
        gv_name = gs_saplane-zzname.
        gv_cargo = gs_saplane-zzcargo.

        zcl_airplane_00=>factory(
          EXPORTING
            iv_name         = gv_name
            iv_planetype    = gs_saplane-planetype    " Flugzeugtyp
            iv_seats        = gs_saplane-seatsmax    " Maximaler Frachtraum
            iv_cargo        = gv_cargo    " Maximaler Frachtraum
        ).
      ENDSELECT.

      zcl_airplane_00=>display_all_planes( ).
      " zcl_airplane_00=>get_ref_airplane( 'Berlin')->display_attributes( ).
    CATCH cx_root INTO DATA(go_error).
      MESSAGE go_error->get_text( ) TYPE 'I'.
  ENDTRY.
