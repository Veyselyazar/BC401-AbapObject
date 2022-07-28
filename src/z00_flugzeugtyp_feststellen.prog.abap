*&---------------------------------------------------------------------*
*& Report Z00_SAPLANE_AENDERN
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_flugzeugtyp_feststellen.

PARAMETERS pa_plane TYPE saplane-planetype.
DATA gs_saplane TYPE saplane.
SELECT SINGLE * FROM saplane INTO gs_saplane
 WHERE planetype = pa_plane.

DATA(laenge) = strlen( gs_saplane-planetype ) - 1.
IF gs_saplane-planetype+laenge = 'F'.
  WRITE 'Frachtflugzeug'.
ELSE.
  WRITE 'Passagierflugzeug'.
ENDIF.
