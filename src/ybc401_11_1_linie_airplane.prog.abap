*&---------------------------------------------------------------------*
*& Report Z00_LINIE_AIRPLANE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z00_LINIE_AIRPLANE.

CLASS-DATA: "Private Klasse

PRIVATE SECTION.
      MV_FLUGZEUGNAME   TYPE string, "IST INSTANZ-ATTRIBUTE
      MV_PLANETTYP      TYPE SAPLANE-PLANETYPE, "IST INSTANZ-ATTRIBUTE
      GV_FLUGZEUGE      TYPE z00_summe.
      GV_ANZAHL_FLUGZEUGE TYPE

MV_FLUGZEUGNAME = 'Airlines'.
MV_PLANETTYP = 'Hamburg'.

WRITE: 'FLUGZEUGNAME', MV_FLUGZEUGNAME.

PUBLIC SECTION.

    METHOD SETZE_EIGENSCHAFTEN

    METHOD ZEIGE_EIGENSCHAFTEN cnfg

METHOD DISPLAY _ATTRIBUTES.

LEFT-JUSTIFED.


LCL_AIRPLANE=>ANZEIGE_ANZAHL_FLUGZEUGE " => HANDELT SICH UM STATISCHE METHODE


CLASS IMPLEMENTATION



  ENDCLASS.

*CLASS DEFINITION

*START-OF-SELECTION








CLASS LINIE_AIRPLANE DEFINITION.


CLASS-METHODS ADD





  PUBLIC SECTION.

    class-METHODS ADD

      IMPORTING
        iv_zahl1 TYPE i
        iv_zahl2 TYPE i
      EXPORTING
        ev_summe TYPE i
      EXCEPTIONS
        wrong_import.

  PROTECTED SECTION.

  PRIVATE SECTION.



ENDCLASS.


CLASS lcl_lokal IMPLEMENTATION.

   METHOD add.

    IF iv_zahl1 IS NOT INITIAL AND iv_zahl2 IS NOT INITIAL.
      ev_summe = iv_zahl1 + iv_zahl2.
      gv_gesamtsumme = gv_gesamtsumme + ev_summe.
    ELSE.
      RAISE wrong_import.
    ENDIF.

  ENDMETHOD.

ENDCLASS.



* Hauptprogramm
DATA gv_summe TYPE i.
data gv_zahl type DECFLOAT34.

START-OF-SELECTION.
  CALL METHOD lcl_lokal=>add
    EXPORTING
      iv_zahl1     = -45
      iv_zahl2     = 12
    IMPORTING
      ev_summe     = gv_summe
    EXCEPTIONS
      wrong_import = 1.

  IF sy-subrc =  1.
    WRITE 'Mindestens ein Parameter war Null'.
  ELSE.
    WRITE: / 'Die berechnete Summe', gv_summe.
  ENDIF.
