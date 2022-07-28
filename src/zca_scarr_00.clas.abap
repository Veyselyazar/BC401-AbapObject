class ZCA_SCARR_00 definition
  public
  inheriting from ZCB_SCARR_00
  final
  create private .

public section.

  class-data AGENT type ref to ZCA_SCARR_00 read-only .

  class-methods CLASS_CONSTRUCTOR .
protected section.
private section.
ENDCLASS.



CLASS ZCA_SCARR_00 IMPLEMENTATION.


  method CLASS_CONSTRUCTOR.
***BUILD 090501
************************************************************************
* Purpose        : Initialize the 'class'.
*
* Version        : 2.0
*
* Precondition   : -
*
* Postcondition  : Singleton is created.
*
* OO Exceptions  : -
*
* Implementation : -
*
************************************************************************
* Changelog:
* - 1999-09-20   : (OS) Initial Version
* - 2000-03-06   : (BGR) 2.0 modified REGISTER_CLASS_AGENT
************************************************************************
* GENERATED: Do not modify
************************************************************************

  create object AGENT.

  call method AGENT->REGISTER_CLASS_AGENT
    exporting
      I_CLASS_NAME          = 'ZCL_SCARR_00'
      I_CLASS_AGENT_NAME    = 'ZCA_SCARR_00'
      I_CLASS_GUID          = '00505604273F1EECBB924E50216CE5EE'
      I_CLASS_AGENT_GUID    = '00505604273F1EECBB924E50216DA5EE'
      I_AGENT               = AGENT
      I_STORAGE_LOCATION    = 'SCARR'
      I_CLASS_AGENT_VERSION = '2.0'.

           "CLASS_CONSTRUCTOR
  endmethod.
ENDCLASS.
