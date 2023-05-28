# Jumpstarting ORDS REST API Development: A Comprehensive Guide for Beginners
To utilize the examples and code provided here, it is assumed that you have the standard EMPLOYEES table from the HR schema already installed in your Oracle database. If you haven't installed this table yet, please follow the below steps to set it up before proceeding.
  1. Go to SQL Workshop in your APEX environment.
  2. Navigate to Utilities.
  3. Select Sample Datasets.
  4. Look for the "HR Data" dataset and choose to install it.

To ensure the proper execution and setup of the components mentioned, please follow the script in the given order:

1. Alter the EMPLOYEES table to add additional columns to the EMPLOYEES table.
2. Create HR_API_V1 package: Develop the HR_API_V1 package that handles the functionalities specific to the hr/v1/ module. 
3. Create HR_API_V2 package: Develop the HR_API_V2 package that handles the functionalities specific to the hr/v2/ module. 
4. Create hr/v1/ REST Module.
5. Create hr/v2/ REST Module.
6. Script to create client for OAuth2.0: Prepare the script that creates a client for OAuth2.0 authentication. This step involves generating a client ID and client secret, which will be used for requesting access tokens.
7. Postman Collection for hr/v1 module. Create "base_url" environmnet variabl in Postman.
8. Postman Collection for hr/v2 module.

By executing the script in the given order, you will set up the necessary database structures, create the API packages, configure the REST modules, and establish the Postman collections for testing and interacting with the APIs.
[Mastering REST API using Oracle APEX (INOAUG Xplore - May 2023)](https://www.youtube.com/watch?v=zfnneRc4hw8)
