*&---------------------------------------------------------------------*
*& Report Z00_FINALE_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_finale_klasse.

CLASS lcl_final DEFINITION final ABSTRACT .
  PUBLIC SECTION.
    METHODS set_gehalt .


ENDCLASS.
CLASS lcl_final IMPLEMENTATION.
  METHOD set_gehalt.
  ENDMETHOD.
ENDCLASS.
*CLASS lcl_uk DEFINITION INHERITING FROM lcl_final.
*  PUBLIC SECTION.
*    methods set_gehalt REDEFINITION.
*ENDCLASS.
