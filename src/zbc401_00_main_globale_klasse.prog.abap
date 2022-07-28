*&---------------------------------------------------------------------*
*& Report ZBC401_00_MAIN #
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zbc401_00_main_lobale_klasse.

DATA go_cargo TYPE REF TO zcl_cargo_plane_00.
DATA go_pass TYPE REF TO zcl_passenger_plane_00.

DATA gv_cargo TYPE scplane-cargomax.
* Hauptprogramm
DATA: go_klasse TYPE z00_klasse.


DATA: gv_name      TYPE string,
      gv_planetype TYPE saplane-planetype.
DATA gv_laenge TYPE i.
DATA gs_saplane TYPE saplane.

TYPES: BEGIN OF ty_flugzeug,
         name TYPE string,
         typ  TYPE saplane-planetype,
         ref  TYPE REF TO zcl_airplane_00,
       END OF ty_flugzeug.
DATA: gs_flugzeug  TYPE ty_flugzeug,
      gt_flugzeuge TYPE TABLE OF ty_flugzeug.

START-OF-SELECTION.

  zcl_cargo_plane_00=>display_n_o_airplanes( ).

  "SELECT zzname planetype zzcargo FROM saplane INTO (gv_name, gv_planetype, gv_cargo).
  SELECT * FROM saplane INTO gs_saplane where zzname <> space.
    gv_name = gs_saplane-zzname.
    gv_cargo = gs_saplane-zzcargo.
    gv_laenge = strlen( gs_saplane-planetype ) - 1 .
    IF gs_saplane-planetype+gv_laenge = 'F'.

*      CREATE OBJECT go_klasse TYPE zcl_cargo_plane_00 "implizites upcasting
*        EXPORTING
*          iv_name         = gv_name
*          iv_planetype    = gs_saplane-planetype
*          iv_cargo        = gv_cargo
*        EXCEPTIONS
*          wrong_planetype = 1.
   go_klasse = new zcl_cargo_plane_00(
     iv_name         = gv_name
     iv_planetype    = gs_saplane-planetype
     iv_cargo        = gv_cargo ).
      " import_name_empty = 2.
*      IF sy-subrc = 0.
*        go_klasse->add_reference_into_table( go_cargo ).
*        gs_flugzeug-name = gv_name.
*        gs_flugzeug-typ  = gs_saplane-planetype.
*        gs_flugzeug-ref  = go_klasse. "implizites upcasting
*        INSERT gs_flugzeug INTO TABLE gt_flugzeuge.
*      ENDIF.

    ELSE.
      CREATE OBJECT go_klasse TYPE zcl_passenger_plane_00
        EXPORTING
          iv_name         = gv_name
          iv_planetype    = gs_saplane-planetype
          iv_seats        = gs_saplane-seatsmax
        EXCEPTIONS
          wrong_planetype = 1.

    ENDIF.
    IF go_klasse IS NOT INITIAL.
      go_klasse->add_reference_into_table( go_pass ).
      gs_flugzeug-name = gv_name.
      gs_flugzeug-typ  = gs_saplane-planetype.
      gs_flugzeug-ref  = go_klasse. "implizites upcasting
      INSERT gs_flugzeug INTO TABLE gt_flugzeuge.
    ENDIF.



  ENDSELECT.
  CLEAR gs_flugzeug.


  "zcl_airplane_00=>get_ref_airplane( 'Mainz' )->display_attributes( ).
  "go_klasse->display_attributes( ).


*  READ TABLE gt_flugzeuge INTO gs_flugzeug
*    WITH KEY name = 'Mainz'.
*  IF sy-subrc = 0.
*    gs_flugzeug-ref->display_attributes( ).
*  ENDIF.

*  READ TABLE gt_flugzeuge INTO gs_flugzeug
*    WITH KEY ref->mv_name = 'Mainz'.
*  IF sy-subrc = 0.
*    gs_flugzeug-ref->display_attributes( ).
*  ENDIF.

*  READ TABLE gt_flugzeuge INTO gs_flugzeug
*    WITH KEY typ = '747-400'.
*  IF sy-subrc = 0.
*    gs_flugzeug-ref->display_attributes( ).
*  ENDIF.
*  READ TABLE gt_flugzeuge INTO gs_flugzeug
*  WITH KEY ref->mv_planetype = '747-400'.
*  IF sy-subrc = 0.
*    gs_flugzeug-ref->display_attributes( ).
*  ENDIF.


  """ zcl_cargo_plane_00=>display_alle_instanzen( ).



*  go_klasse->display_n_o_airplanes( ).
*  ULINE.


  WRITE: `Anzahl Objekte aus Funktionaler Methode: ` && zcl_airplane_00=>get_n_o_airplanes( ).

  ULINE.
