--Create Client

BEGIN
      OAUTH.create_client(
          p_name            => 'rutvik.prajapati',
          p_grant_type      => 'client_credentials',
          p_owner           => 'WKSP_WS1',
          p_description     => 'Internal client to access agreement API',
          p_support_email   => 'rutveek@gmail.com',
          p_privilege_names => 'inaoug.demo.privilege' 
     );
 
     COMMIT;
END;
/

--Assign a Role to Client

BEGIN
  OAUTH.grant_client_role(
    p_client_name => 'rutvik.prajapati',
    p_role_name   => 'inaoug.demo.role'
  );
 
  COMMIT;
END;
/

--get client id and secret

SELECT NAME,
       DESCRIPTION,
       CLIENT_ID,
       CLIENT_SECRET
FROM ords_metadata.user_ords_clients 
WHERE NAME = 'rutvik.prajapati';