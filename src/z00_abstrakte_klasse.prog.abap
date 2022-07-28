*&---------------------------------------------------------------------*
*& Report Z00_ABSTRAKTE_KLASSE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z00_abstrakte_klasse.

CLASS lcl_abstract DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS m_abstract  IMPORTING iv_text TYPE string .
  PROTECTED SECTION.
    DATA mv_text TYPE string.
ENDCLASS.
CLASS lcl_abstract IMPLEMENTATION.
  METHOD m_abstract.

  ENDMETHOD.
ENDCLASS.
CLASS lcl_uk DEFINITION INHERITING FROM lcl_abstract.
  PUBLIC SECTION.
    METHODS m_abstract REDEFINITION.
ENDCLASS.
CLASS lcl_uk IMPLEMENTATION.
  METHOD m_abstract.
    mv_text = iv_text.
  ENDMETHOD.
ENDCLASS.

DATA go_ab TYPE REF TO lcl_abstract.
*DATA go_uk TYPE REF TO lcl_uk.
*
*CREATE OBJECT go_uk.
*go_ab = go_uk.
