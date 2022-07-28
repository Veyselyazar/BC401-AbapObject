*&---------------------------------------------------------------------*
*& Report Z00_AIRPLANE_AUSLESEN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_airplane_auslesen.

DATA gs_saplane TYPE saplane.

SELECT * FROM saplane INTO gs_saplane
  WHERE zzname NE space.

ENDSELECT.
