## Guidelines for Using The Dataset

> **NOTE:** Download all the necessary materials and datasets before starting this project

### Option 1: Create Project Database by Running Script

When creating a database and schema, one thing to consider in this script is the location where the downloaded dataset is stored on the device.
[Script for create database and schemas](https://github.com/CHodes-dev/SQL-Data-Warehouse-Project/blob/main/scripts/init_database.sql)

### Option 2: Import Flat Files to Database

Follow this steps:
1. Right-click on **Databases folder** in Object Explorer > New Database...
2. [New Database window opened] Enter the name of the new database > OK
3. Right-click on new database > Tasks > Import Flat File...
4. [Import Flat File window opened] Introduction > Next
5. Specify Input File > Location of file to be imported > Browse > *search csv file on computer*
6. Preview Data > Next
7. Modify Columns > Checklist option 'Allow Nulls' > Next
8. Summary > Next
9. Results > OK

Repeat the steps from the first to the last for the other files.

> The data imported into the database for this specific option, which is located in the gold layer.
> [Script for create gold layer](https://github.com/CHodes-dev/SQL-Data-Warehouse-Project/blob/main/scripts/gold/ddl_gold.sql)

### Option 3: Restore the project database

Follow this steps:
1. Copy .bak file of database to location where you have installed the SQL Server
2. Right-click on **Databases folder** in Object Explorer > Restore Database...
3. [Restore Database window opened] select Device on Source > click '...'
4. [Select backup devices window openend] select Add
5. [Locate Backup File opened] select database .bak file > OK

*It is recommended that you carry out the **SQL Data Warehouse Project** first and then move on to this project.*
