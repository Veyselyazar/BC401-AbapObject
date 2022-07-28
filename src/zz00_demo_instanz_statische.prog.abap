*&---------------------------------------------------------------------*
*& Report ZZ00_DEMO_INSTANZ_STATISCHE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZZ00_DEMO_INSTANZ_STATISCHE.

**zcl_bc401=>add(
**  EXPORTING
**    iv_zahl1     = 45    " Natürliche Zahl
**    iv_zahl2     = 12    " Natürliche Zahl
**).

data go_zahlen type REF TO zcl_bc401. " 8 Byte mit Möglichkeit auf ein Objekt
data go_zahlen2 type REF TO zcl_bc401.
create OBJECT go_zahlen.

go_zahlen->add(   "Statische Methode
  EXPORTING
    iv_zahl1     = 100    " Natürliche Zahl
    iv_zahl2     =  20    " Natürliche Zahl
).
go_zahlen->multipliziere(
  EXPORTING
    iv_zahl1 =  100   " Natürliche Zahl
    iv_zahl2 =   20  " Natürliche Zahl
).

create OBJECT go_zahlen2.

go_zahlen2->multipliziere(
  EXPORTING
    iv_zahl1 =  5   " Natürliche Zahl
    iv_zahl2 =   8  " Natürliche Zahl
).

go_zahlen2->add(  "Statische Methode
  EXPORTING
    iv_zahl1     = 111    " Natürliche Zahl
    iv_zahl2     = 222    " Natürliche Zahl
).



zcl_bc401=>add(  "Statische
  EXPORTING
    iv_zahl1     = 45    " Natürliche Zahl
    iv_zahl2     = 12    " Natürliche Zahl
).


data(gv_flaeche) = 100 * zcl_bc401=>gc_pi.
gv_flaeche = 100 * go_zahlen2->gc_pi.

BREAK-POINT.
