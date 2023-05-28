create or replace PACKAGE HR_API_V2 IS
--------------------------------------------------------------
-- create procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
 procedure create_emp (
      P_REQUEST_BODY   in  clob,
      P_RES_LOC        OUT varchar2,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2                         
   );

--------------------------------------------------------------
-- update procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
   procedure update_emp (
      P_EMPLOYEE_ID    in  number,
      P_REQUEST_BODY   in  clob,
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


--------------------------------------------------------------
--  procedure to update employee photo
--------------------------------------------------------------

procedure update_photo(
    P_EMPLOYEE_ID   in  number,
    P_CONTENT       in  blob,
    P_CONTENT_TYPE  in  varchar2,
    P_FILE_NAME     in  varchar2,
    P_RES_LOC       OUT varchar2,
    P_STATUS_CD     OUT number,
    P_STATUS_MSG    OUT varchar2
);


END HR_API_V2;

/

create or replace PACKAGE BODY HR_API_V2 IS
--------------------------------------------------------------
-- create procedure for table "OEHR_EMPLOYEES"
--------------------------------------------------------------
 procedure create_emp (
      P_REQUEST_BODY   in  clob,
      P_RES_LOC        OUT varchar2, 
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2                          
   ) IS
    
    v_body           CLOB;
    json_content     APEX_JSON.t_values;
    v_employee_id    VARCHAR2(20);
    v_first_name     VARCHAR2(20);
    v_last_name      VARCHAR2(20);
    v_email          VARCHAR2(20);
    v_phone_number   VARCHAR2(20);
    v_hire_date      VARCHAR2(20);
    v_job_id         VARCHAR2(20);
    v_salary         VARCHAR2(20);
    v_commission_pct VARCHAR2(20);
    v_manager_id     VARCHAR2(20);
    v_department_id  VARCHAR2(20);
    v_error_msg      VARCHAR2(500);
    v_error_cd       NUMBER;
    E_bad_request EXCEPTION;
    
   BEGIN
        
        v_body := P_REQUEST_BODY;

        --
        -- Parse json body
        --
        APEX_JSON.parse(json_content, v_body);
        v_employee_id    := APEX_JSON.get_varchar2(p_path => 'employee_id', p_values => json_content);
        v_first_name     := APEX_JSON.get_varchar2(p_path => 'first_name', p_values => json_content);
        v_last_name      := APEX_JSON.get_varchar2(p_path => 'last_name', p_values => json_content);
        v_email          := APEX_JSON.get_varchar2(p_path => 'email', p_values => json_content);
        v_phone_number   := APEX_JSON.get_varchar2(p_path => 'phone_number', p_values => json_content);
        v_hire_date      := APEX_JSON.get_varchar2(p_path => 'hire_date', p_values => json_content);
        v_job_id         := APEX_JSON.get_varchar2(p_path => 'job_id', p_values => json_content);
        v_salary         := APEX_JSON.get_varchar2(p_path => 'salary', p_values => json_content);
        v_commission_pct := APEX_JSON.get_varchar2(p_path => 'commission_pct', p_values => json_content);
        v_manager_id     := APEX_JSON.get_varchar2(p_path => 'manager_id', p_values => json_content);
        v_department_id  := APEX_JSON.get_varchar2(p_path => 'department_id', p_values => json_content);

        /**
        ** Validate Input Parameters
        **/
        IF v_first_name IS NULL THEN
            v_error_msg := 'first_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
        
        IF v_last_name IS NULL THEN
            v_error_msg := 'last_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
   
        IF v_email IS NULL THEN
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
         v_employee_id ,
         v_first_name,
         v_last_name,
         v_email,
         v_phone_number,
         TO_DATE(v_hire_date,'YYYY/MM/DD'),
         v_job_id ,
         v_salary,
         v_commission_pct,
         v_manager_id,
         v_department_id
      ) ;
      
      P_res_loc    := './'||v_employee_id ; 
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
      P_REQUEST_BODY   in  clob,
      P_RES_LOC        OUT varchar2,
      P_STATUS_CD      OUT number,
      P_STATUS_MSG     OUT varchar2   
   ) IS

    v_body           CLOB;
    json_content     APEX_JSON.t_values;
    v_employee_id    VARCHAR2(20);
    v_first_name     VARCHAR2(20);
    v_last_name      VARCHAR2(20);
    v_email          VARCHAR2(20);
    v_phone_number   VARCHAR2(20);
    v_hire_date      VARCHAR2(20);
    v_job_id         VARCHAR2(20);
    v_salary         VARCHAR2(20);
    v_commission_pct VARCHAR2(20);
    v_manager_id     VARCHAR2(20);
    v_department_id  VARCHAR2(20);
    v_error_msg      VARCHAR2(500);
    v_error_cd       NUMBER;
    E_bad_request    EXCEPTION;

   BEGIN

        v_body := P_REQUEST_BODY;

        --
        -- Parse json body
        --
        APEX_JSON.parse(json_content, v_body);
        v_employee_id    := P_EMPLOYEE_ID;
        v_first_name     := APEX_JSON.get_varchar2(p_path => 'first_name', p_values => json_content);
        v_last_name      := APEX_JSON.get_varchar2(p_path => 'last_name', p_values => json_content);
        v_email          := APEX_JSON.get_varchar2(p_path => 'email', p_values => json_content);
        v_phone_number   := APEX_JSON.get_varchar2(p_path => 'phone_number', p_values => json_content);
        v_hire_date      := APEX_JSON.get_varchar2(p_path => 'hire_date', p_values => json_content);
        v_job_id         := APEX_JSON.get_varchar2(p_path => 'job_id', p_values => json_content);
        v_salary         := APEX_JSON.get_varchar2(p_path => 'salary', p_values => json_content);
        v_commission_pct := APEX_JSON.get_varchar2(p_path => 'commission_pct', p_values => json_content);
        v_manager_id     := APEX_JSON.get_varchar2(p_path => 'manager_id', p_values => json_content);
        v_department_id  := APEX_JSON.get_varchar2(p_path => 'department_id', p_values => json_content);

        /**
        ** Validate Input Parameters
        **/
        
        IF v_employee_id IS NULL THEN
            v_error_msg := 'employee_id cannot be null';
            v_error_cd  := 400;
            RAISE E_bad_request;
        END IF;
        
        IF v_first_name IS NULL THEN
            v_error_msg := 'first_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
        
        IF v_last_name IS NULL THEN
            v_error_msg := 'last_name cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF;
   
        IF v_email IS NULL THEN
            v_error_msg := 'email cannot be null';
            v_error_cd := 400; --Bad Request
            RAISE E_bad_request;
        END IF; 

       --
       -- Update record
       --

        FOR i IN (SELECT * FROM oehr_employees e WHERE e.employee_id = P_EMPLOYEE_ID)
        LOOP
            UPDATE oehr_employees 
             SET first_name     = NVL(v_first_name, i.first_name),
                 last_name      = NVL(v_last_name, i.last_name),
                 email          = NVL(v_email, i.email),
                 phone_number   = NVL(v_phone_number, i.phone_number),
                 hire_date      = NVL(TO_DATE(v_hire_date,'YYYY/MM/DD'),i.hire_date),
                 job_id         = NVL(v_job_id,i.job_id),
                 salary         = NVL(v_salary,i.salary),
                 commission_pct = NVL(v_commission_pct, i.commission_pct),
                 manager_id     = NVL(v_manager_id,i.manager_id),
                 department_id  = NVL(v_department_id,department_id)
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

--------------------------------------------------------------
--  procedure to update employee photo
--------------------------------------------------------------

procedure update_photo(
    P_EMPLOYEE_ID   in  number,
    P_CONTENT       in  blob,
    P_CONTENT_TYPE  in  varchar2,
    P_FILE_NAME     in  varchar2,
    P_RES_LOC       OUT varchar2,
    P_STATUS_CD     OUT number,
    P_STATUS_MSG    OUT varchar2
) IS
    v_content     BLOB;
    E_bad_request EXCEPTION;
    v_error_msg   VARCHAR2(500);
    v_error_cd    NUMBER;

BEGIN

    v_content := P_CONTENT;


    UPDATE oehr_employees e
    SET e.mime_type    = P_CONTENT_TYPE,
        e.file_name    = P_FILE_NAME,
        e.content      = v_content
    WHERE e.employee_id = P_EMPLOYEE_ID;

    IF SQL%FOUND THEN
            P_res_loc    := './'; 
            P_STATUS_CD  := 200;
            P_STATUS_MSG := 'content successfully updated';
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
 
END update_photo;



END HR_API_V2;