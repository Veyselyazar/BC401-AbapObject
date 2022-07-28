*&---------------------------------------------------------------------*
*& Report Z00_MITA_ANLEGEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_mita_anlegen.

INTERFACE lif_drucken.
  DATA druck_datum TYPE sy-datum.
  METHODS display_druckdatum.
  CLASS-DATA benutzername TYPE syuname.
ENDINTERFACE.


CLASS lcl_azubi DEFINITION INHERITING FROM zcl_mita_00 create PUBLIC.
  PUBLIC SECTION.
    INTERFACES lif_drucken.
    METHODS constructor
      IMPORTING
                iv_vorname  TYPE string
                iv_nachname TYPE string
                iv_lehrjahr TYPE i
      RAISING   zcx_00_bc401_nk.


    METHODS set_lehrjahr IMPORTING iv_jahr TYPE i.
    METHODS display_mita_daten REDEFINITION.
  PRIVATE SECTION.
    DATA mv_lehrjahr TYPE i.
ENDCLASS.
CLASS lcl_azubi IMPLEMENTATION.
  METHOD constructor.

    super->constructor(
      EXPORTING
        iv_vorname  = iv_vorname
        iv_nachname = iv_nachname
    ).


    IF  iv_lehrjahr IS INITIAL.
      RAISE EXCEPTION TYPE zcx_00_bc401_nk
        EXPORTING
          textid = zcx_00_bc401_nk=>azubi_initial.
    ENDIF.
    mv_lehrjahr = iv_lehrjahr.


  ENDMETHOD.
  METHOD display_mita_daten.
    super->display_mita_daten( ).
    WRITE: / 'Implementierung der Azubi-Klasse', mv_lehrjahr.
  ENDMETHOD.
  METHOD set_lehrjahr.
    mv_lehrjahr = iv_jahr.
  ENDMETHOD.
  METHOD lif_drucken~display_druckdatum.
    WRITE: / 'Druckdatum', lif_drucken~druck_datum.
  ENDMETHOD.
ENDCLASS.

DATA go_mita TYPE REF TO zcl_mita_00.
DATA go_mita_frei TYPE REF TO zcl_mita_00_frei.
DATA gt_mita TYPE TABLE OF REF TO zcl_mita_00.
DATA go_azubi TYPE REF TO lcl_azubi.

START-OF-SELECTION.
  lcl_azubi=>lif_drucken~benutzername = sy-uname.
  CREATE OBJECT go_mita EXPORTING iv_vorname = 'Werner' iv_nachname = 'Müller'.
  APPEND go_mita TO gt_mita.
  TRY.
      CREATE OBJECT go_mita_frei
        EXPORTING
          iv_vorname  = ''
          iv_nachname = 'Schmitz'
       iv_stundensatz = 12.

      APPEND go_mita_frei TO gt_mita.
    CATCH zcx_00_bc401_nk INTO DATA(go_resume).

    CATCH cx_sy_arithmetic_error   .
      MESSAGE 'Abbruch wegen Rechenfehler' TYPE 'A'.
    CATCH cx_root INTO DATA(go).
      MESSAGE go->get_text( ) TYPE 'I'.
  ENDTRY.

  DATA gv_lj TYPE i VALUE 0.
  TRY.
      CREATE OBJECT go_azubi
        EXPORTING
          iv_vorname  = 'Benjamin'
          iv_nachname = 'Müller'
          iv_lehrjahr = gv_lj.
      go_azubi->lif_drucken~druck_datum = sy-datum.
      APPEND go_azubi TO gt_mita.
    CATCH cx_root INTO DATA(go_error).
      MESSAGE go_error->get_text( ) TYPE 'I'.

      gv_lj = 3.
      RETRY.
  ENDTRY.






  LOOP AT gt_mita INTO go_mita.
    go_mita->display_mita_daten( ).
    IF go_mita IS INSTANCE OF lcl_azubi.
      go_azubi ?= go_mita.
      go_azubi->lif_drucken~display_druckdatum( ).
    ENDIF.
  ENDLOOP.
