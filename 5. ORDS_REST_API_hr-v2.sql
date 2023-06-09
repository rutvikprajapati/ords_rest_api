
-- Generated by ORDS REST Data Services 23.1.2.r1151944
-- Schema: WKSP_WS1  Date: Thu May 04 09:44:25 2023 
--

BEGIN
  ORDS.ENABLE_SCHEMA(
      p_enabled             => TRUE,
      p_schema              => 'WKSP_WS1',
      p_url_mapping_type    => 'BASE_PATH',
      p_url_mapping_pattern => 'apidemo',
      p_auto_rest_auth      => FALSE);
    
  ORDS.DEFINE_MODULE(
      p_module_name    => 'hr/v2/',
      p_base_path      => '/hr/v2/',
      p_items_per_page => 25,
      p_status         => 'PUBLISHED',
      p_comments       => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/',
      p_method         => 'POST',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
   HR_API_V2.CREATE_EMP(
      P_REQUEST_BODY   => :body_text,
      P_RES_LOC        => :res_location,
      P_STATUS_CD      => :status,
      P_STATUS_MSG     => :status_msg  
   );
   
END;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/',
      p_method             => 'POST',
      p_name               => '$self',
      p_bind_variable_name => 'res_location',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/',
      p_method             => 'POST',
      p_name               => 'X-ORDS-STATUS-CODE',
      p_bind_variable_name => 'status',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/',
      p_method             => 'POST',
      p_name               => 'status_msg',
      p_bind_variable_name => 'status_msg',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT * 
FROM OEHR_EMP_DETAILS_VIEW');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/',
      p_method             => 'GET',
      p_name               => 'output',
      p_bind_variable_name => 'ret',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'RESULTSET',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id/photo/',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id/photo/',
      p_method         => 'GET',
      p_source_type    => 'resource/lob',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'SELECT mime_type,
       content
FROM oehr_employees 
WHERE employee_id = :id');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id/photo/',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => 'Update Photo',
      p_source         => 
'BEGIN
   HR_API_V2.UPDATE_PHOTO(
      P_EMPLOYEE_ID   => :id,
      P_CONTENT       => :body,
      P_CONTENT_TYPE  => :mime_type,
      P_FILE_NAME     => :file_name,
      P_RES_LOC       => :res_location,
      P_STATUS_CD     => :status,
      P_STATUS_MSG    => :status_msg 
   );
   
END;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id/photo/',
      p_method             => 'PUT',
      p_name               => 'status_msg',
      p_bind_variable_name => 'status_msg',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id/photo/',
      p_method             => 'PUT',
      p_name               => 'X-ORDS-STATUS-CODE',
      p_bind_variable_name => 'status',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id/photo/',
      p_method             => 'PUT',
      p_name               => '$self',
      p_bind_variable_name => 'res_location',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id/photo/',
      p_method             => 'PUT',
      p_name               => 'mime_type',
      p_bind_variable_name => 'mime_type',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id/photo/',
      p_method             => 'PUT',
      p_name               => 'file_name',
      p_bind_variable_name => 'file_name',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'IN',
      p_comments           => NULL);

  ORDS.DEFINE_TEMPLATE(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id',
      p_priority       => 0,
      p_etag_type      => 'HASH',
      p_etag_query     => NULL,
      p_comments       => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id',
      p_method         => 'GET',
      p_source_type    => 'json/collection',
      p_mimes_allowed  => NULL,
      p_comments       => 'Get a single record',
      p_source         => 
'SELECT * 
FROM OEHR_EMP_DETAILS_VIEW e
WHERE e.employee_id = :id');

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id',
      p_method         => 'PUT',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
   HR_API_V2.UPDATE_EMP(
      P_EMPLOYEE_ID    => :id,
      P_REQUEST_BODY   => :body_text,
      P_RES_LOC        => :res_location,
      P_STATUS_CD      => :status,
      P_STATUS_MSG     => :status_msg  
   );
   
END;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'X-ORDS-STATUS-CODE',
      p_bind_variable_name => 'status',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'status_msg',
      p_bind_variable_name => 'status_msg',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id',
      p_method             => 'PUT',
      p_name               => 'X-ORDS-FORWARD-LOCATION',
      p_bind_variable_name => 'res_location',
      p_source_type        => 'HEADER',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_HANDLER(
      p_module_name    => 'hr/v2/',
      p_pattern        => 'employees/:id',
      p_method         => 'DELETE',
      p_source_type    => 'plsql/block',
      p_mimes_allowed  => NULL,
      p_comments       => NULL,
      p_source         => 
'BEGIN
   HR_API_V1.DELETE_EMP(
      P_EMPLOYEE_ID    => :id,
      P_STATUS_CD      => :status,
      P_STATUS_MSG     => :status_msg  
   );
   
END;');

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id',
      p_method             => 'DELETE',
      p_name               => 'X-ORDS-STATUS-CODE',
      p_bind_variable_name => 'status',
      p_source_type        => 'HEADER',
      p_param_type         => 'INT',
      p_access_method      => 'OUT',
      p_comments           => NULL);

  ORDS.DEFINE_PARAMETER(
      p_module_name        => 'hr/v2/',
      p_pattern            => 'employees/:id',
      p_method             => 'DELETE',
      p_name               => 'status_msg',
      p_bind_variable_name => 'status_msg',
      p_source_type        => 'RESPONSE',
      p_param_type         => 'STRING',
      p_access_method      => 'OUT',
      p_comments           => NULL);

    
        
COMMIT;

END;