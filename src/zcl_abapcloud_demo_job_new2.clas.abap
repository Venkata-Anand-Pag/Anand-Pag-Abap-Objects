CLASS zcl_abapcloud_demo_job_new2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_apj_dt_exec_object .
    INTERFACES if_apj_rt_exec_object .
    INTERFACES if_oo_adt_classrun. "test

  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS check_params
      EXPORTING
        !ev_successful TYPE abap_BOOLEAN
      CHANGING
        !ct_value      TYPE if_apj_types=>tt_jt_selopt .
    METHODS generate_log.
*    importing
*      !IT_MESSAGE type TY_T_MESSAGES
*      !IV_EXTNUMBER type ty_extnumber optional .
ENDCLASS.



CLASS ZCL_ABAPCLOUD_DEMO_JOB_NEW2 IMPLEMENTATION.


  METHOD check_params.
    ev_successful = abap_true.
  ENDMETHOD.


  METHOD generate_log.

  ENDMETHOD.


  METHOD if_apj_dt_exec_object~get_parameters.
  ENDMETHOD.


  METHOD if_apj_rt_exec_object~execute.
  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.
*    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.
*    TRY.
*        me->if_apj_rt_exec_object~execute( EXPORTING it_parameters = lt_parameters ).
*      CATCH cx_apj_rt_content INTO DATA(lx_content).
*        IF lx_content IS BOUND.
*        ENDIF.
*    ENDTRY.
  ENDMETHOD.
ENDCLASS.
