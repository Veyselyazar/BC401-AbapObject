*&---------------------------------------------------------------------*
*& Report Z00_EREIGNIS_AUSLOESEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_ereignis_ausloesen.

CLASS lcl_ausloeser DEFINITION.
  PUBLIC SECTION.
    EVENTS: mitarbeiter_erzeugt EXPORTING VALUE(ev_name) TYPE string.
    METHODS constructor IMPORTING iv_name TYPE string.
    METHODS display.
  PRIVATE SECTION.
    DATA mv_name TYPE string.
ENDCLASS.
CLASS lcl_ausloeser IMPLEMENTATION.
  METHOD constructor.
    mv_name = iv_name.
    RAISE EVENT mitarbeiter_erzeugt EXPORTING ev_name = mv_name.
  ENDMETHOD.
  METHOD display.
    WRITE: 'Name', mv_name.
  ENDMETHOD.
ENDCLASS.
CLASS lcl_handler DEFINITION.
  PUBLIC SECTION.
    EVENTS tabelleneintrag_erfasst.
    METHODS on_mitarbeiter_erzeugt
      FOR EVENT mitarbeiter_erzeugt
                OF lcl_ausloeser
      IMPORTING ev_name.
    CLASS-DATA mt_mita TYPE TABLE OF string.
ENDCLASS.
CLASS lcl_handler IMPLEMENTATION.
  METHOD on_mitarbeiter_erzeugt.
    "MESSAGE 'Mitarbeiter in anderer Klasse erzeugt' TYPE 'I'.
    APPEND ev_name TO mt_mita.
    RAISE EVENT tabelleneintrag_erfasst.
  ENDMETHOD.
ENDCLASS.

DATA go_aus TYPE REF TO lcl_ausloeser.
DATA go_handler TYPE REF TO lcl_handler.

START-OF-SELECTION.
  CREATE OBJECT go_handler.
  SET HANDLER go_handler->on_mitarbeiter_erzeugt FOR ALL INSTANCES.

  CREATE OBJECT go_aus EXPORTING iv_name = 'Müller'.
  CREATE OBJECT go_aus EXPORTING iv_name = 'Maier'.
  CREATE OBJECT go_aus EXPORTING iv_name = 'Schmitz'.
  CREATE OBJECT go_aus EXPORTING iv_name = 'Kunz'.

  LOOP AT go_handler->mt_mita INTO DATA(gv_mitarbeiter).
    WRITE: / gv_mitarbeiter.

  ENDLOOP.
