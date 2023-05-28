create or replace PACKAGE HR_API_V1 IS
--------------------------------------------------------------
-- create procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
 procedure create_emp (
      P_EMPLOYEE_ID    in  number,
      P_FIRST_NAME     in  varchar2 ,                       
      P_LAST_NAME      in  varchar2,
      P_EMAIL          in  varchar2,
      P_PHONE_NUMBER   in  varchar2,                       
      P_HIRE_DATE      in  varchar2,
      P_JOB_ID         in  varchar2,
      P_SALARY         in  number,                         
      P_COMMISSION_PCT in  number,                          
      P_MANAGER_ID     in  number,                         
      P_DEPARTMENT_ID  in  number,
      P_RES_LOC        OUT varchar2,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2                         
   );

--------------------------------------------------------------
-- update procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
   procedure update_emp (
      P_EMPLOYEE_ID    in  number,
      P_FIRST_NAME     in  varchar2     default null,
      P_LAST_NAME      in  varchar2     default null,
      P_EMAIL          in  varchar2     default null,
      P_PHONE_NUMBER   in  varchar2     default null,
      P_HIRE_DATE      in  varchar2     default null,
      P_JOB_ID         in  varchar2     default null,
      P_SALARY         in  number       default null,
      P_COMMISSION_PCT in  number       default null,
      P_MANAGER_ID     in  number       default null,
      P_DEPARTMENT_ID  in  number       default null,
      P_RES_LOC        OUT varchar2,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2   
   );

--------------------------------------------------------------
-- delete procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
procedure delete_emp (
      P_EMPLOYEE_ID    in  number,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2   
   );


END HR_API_V1;
/

create or replace PACKAGE BODY HR_API_V1 IS
--------------------------------------------------------------
-- create procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
 procedure create_emp (
      P_EMPLOYEE_ID    in  number,
      P_FIRST_NAME     in  varchar2 ,                       
      P_LAST_NAME      in  varchar2,
      P_EMAIL          in  varchar2,
      P_PHONE_NUMBER   in  varchar2,                       
      P_HIRE_DATE      in  varchar2,
      P_JOB_ID         in  varchar2,
      P_SALARY         in  number,                         
      P_COMMISSION_PCT in  number,                          
      P_MANAGER_ID     in  number,                         
      P_DEPARTMENT_ID  in  number,
      P_RES_LOC        OUT varchar2, 
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2                          
   ) IS
    
    E_bad_request EXCEPTION;
    v_emp_id      oehr_employees.employee_id%TYPE;
    v_error_msg   VARCHAR2(500);
    v_error_cd    NUMBER;
   BEGIN
        /**
        ** Validate Input Parameters
        **/
        IF P_FIRST_NAME IS NULL THEN
            v_error_msg := 'first_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
        
        IF P_LAST_NAME IS NULL THEN
            v_error_msg := 'last_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
   
        IF P_EMAIL IS NULL THEN
            v_error_msg := 'email cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
        /**
        ** Insert into oher_employees table
        **/
        insert into OEHR_EMPLOYEES (
         EMPLOYEE_ID,
         FIRST_NAME,
         LAST_NAME,
         EMAIL,
         PHONE_NUMBER,
         HIRE_DATE,
         JOB_ID,
         SALARY,
         COMMISSION_PCT,
         MANAGER_ID,
         DEPARTMENT_ID
      ) values ( 
         P_EMPLOYEE_ID,
         P_FIRST_NAME,
         P_LAST_NAME,
         P_EMAIL,
         P_PHONE_NUMBER,
         TO_DATE(P_HIRE_DATE,'YYYY/MM/DD'),
         P_JOB_ID,
         P_SALARY,
         P_COMMISSION_PCT,
         P_MANAGER_ID,
         P_DEPARTMENT_ID
      ) RETURNING employee_id INTO v_emp_id;
      
      P_res_loc    := './'||v_emp_id; 
      P_STATUS_CD  := 201;
      P_STATUS_MSG := 'record successfully created'; 
      
 EXCEPTION
        WHEN E_bad_request THEN
            P_STATUS_CD  := v_error_cd;
            P_STATUS_MSG := v_error_msg;
        WHEN OTHERS THEN
            P_STATUS_CD  := 400;
            P_STATUS_MSG := sqlerrm;
   END create_emp;


--------------------------------------------------------------
-- update procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
   procedure update_emp (
      P_EMPLOYEE_ID    in  number,
      P_FIRST_NAME     in  varchar2     default null,
      P_LAST_NAME      in  varchar2     default null,
      P_EMAIL          in  varchar2     default null,
      P_PHONE_NUMBER   in  varchar2     default null,
      P_HIRE_DATE      in  varchar2     default null,
      P_JOB_ID         in  varchar2     default null,
      P_SALARY         in  number       default null,
      P_COMMISSION_PCT in  number       default null,
      P_MANAGER_ID     in  number       default null,
      P_DEPARTMENT_ID  in  number       default null,
      P_RES_LOC        OUT varchar2,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2   
   ) IS

    E_bad_request EXCEPTION;
    v_error_msg   VARCHAR2(500);
    v_error_cd    NUMBER;

   BEGIN

        /*
        *** Check if  P_employee_id is null or not
        **/
        IF P_EMPLOYEE_ID IS NULL THEN
            v_error_msg := 'id cannot be null';
            v_error_cd  := 400;
            RAISE E_bad_request;
        END IF;
       

        FOR i IN (SELECT * FROM oehr_employees e WHERE e.employee_id = P_EMPLOYEE_ID)
        LOOP
            UPDATE oehr_employees 
             SET first_name     = NVL(P_FIRST_NAME, i.first_name),
                 last_name      = NVL(P_LAST_NAME, i.last_name),
                 email          = NVL(P_EMAIL, i.email),
                 phone_number   = NVL(P_PHONE_NUMBER, i.phone_number),
                 hire_date      = NVL(TO_DATE(P_HIRE_DATE,'YYYY/MM/DD'),i.hire_date),
                 job_id         = NVL(P_JOB_ID,i.job_id),
                 salary         = NVL(P_SALARY,i.salary),
                 commission_pct = NVL(P_COMMISSION_PCT, i.commission_pct),
                 manager_id     = NVL(P_MANAGER_ID,i.manager_id),
                 department_id  = NVL(P_DEPARTMENT_ID,department_id)
           WHERE employee_id = P_EMPLOYEE_ID;
        
        END LOOP;

        IF SQL%FOUND THEN
             P_res_loc    := './'||P_EMPLOYEE_ID; 
            P_STATUS_CD  := 200;
            P_STATUS_MSG := 'record successfully updated';
        ELSE
            P_STATUS_CD  := 400;
            P_STATUS_MSG := 'employee not found';
        END IF;
  
  EXCEPTION
        WHEN E_bad_request THEN
            P_STATUS_CD  := v_error_cd;
            P_STATUS_MSG := v_error_msg;
        WHEN OTHERS THEN
            P_STATUS_CD  := 400;
            P_STATUS_MSG := sqlerrm;
  
  END update_emp;


--------------------------------------------------------------
-- delete procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
procedure delete_emp (
      P_EMPLOYEE_ID    in  number,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2   
   ) IS

    E_bad_request EXCEPTION;
    v_error_msg   VARCHAR2(500);
    v_error_cd    NUMBER;

BEGIN
    
    /*
    *** Check if  P_employee_id is null or not
    **/
    IF P_EMPLOYEE_ID IS NULL THEN
        v_error_msg := 'id cannot be null';
        v_error_cd  := 400;
        RAISE E_bad_request;
    END IF;

    DELETE FROM oehr_employees e
    WHERE e.employee_id = P_EMPLOYEE_ID;

    IF SQL%FOUND THEN
        P_STATUS_CD  := 200;
        P_STATUS_MSG := 'employee '||P_EMPLOYEE_ID||' successfully deleted';
    ELSE
        P_STATUS_CD  := 400;
        P_STATUS_MSG := 'employee not found';
    END IF;


 EXCEPTION
        WHEN E_bad_request THEN
            P_STATUS_CD  := v_error_cd;
            P_STATUS_MSG := v_error_msg;
        WHEN OTHERS THEN
            P_STATUS_CD  := 400;
            P_STATUS_MSG := sqlerrm;

END delete_emp;


END HR_API_V1;

