CREATE DATABASE BaseDeDatosHR;
CREATE DATABASE BaseDeDatosDesarrollo;

/* Me paro en BaseDeDatosHR */
CREATE SCHEMA EsquemaAppA;
CREATE SCHEMA EsquemaAppB;

/* Cambio a BaseDeDatosDesarrollo */
CREATE SCHEMA EsquemaAppA;
CREATE SCHEMA EsquemaAppB;

/*
CREO TABLAS EN LOS ESQUEMAS 
*/
CREATE TABLE BaseDeDatosDesarrollo.EsquemaAppA.tabla1(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosDesarrollo.EsquemaAppA.tabla2(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosDesarrollo.EsquemaAppB.tabla1(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosDesarrollo.EsquemaAppB.tabla2(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosHR.EsquemaAppA.tabla1(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosHR.EsquemaAppA.tabla2(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosHR.EsquemaAppB.tabla1(
   id int,
   puesto varchar(100)
)

CREATE TABLE BaseDeDatosHR.EsquemaAppB.tabla2(
   id int,
   puesto varchar(100)
)

/*
Punto 1 
*/

USE [master]
GO
CREATE LOGIN [admin] WITH PASSWORD=N'123456' MUST_CHANGE, DEFAULT_DATABASE=[master], CHECK_EXPIRATION=ON, CHECK_POLICY=ON
GO
USE [BaseDeDatosDesarrollo]
GO
CREATE USER [admin] FOR LOGIN [admin]
GO
USE [BaseDeDatosDesarrollo]
GO
ALTER USER [admin] WITH DEFAULT_SCHEMA=[EsquemaAppA, EsquemaAppB]
GO
USE [BaseDeDatosDesarrollo]
GO
EXEC sp_addrolemember N'db_owner', N'admin'
GO
USE [BaseDeDatosHR]
GO
CREATE USER [admin] FOR LOGIN [admin]
GO
USE [BaseDeDatosHR]
GO
ALTER USER [admin] WITH DEFAULT_SCHEMA=[EsquemaAppA, EsquemaAppB]
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_owner', N'admin'
GO

/*
Punto 2 
*/

USE [master]
GO
CREATE LOGIN [administracion] WITH PASSWORD=N'123456', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BaseDeDatosHR]
GO
CREATE USER [administracion] FOR LOGIN [administracion]
GO
USE [BaseDeDatosHR]
GO
ALTER USER [administracion] WITH DEFAULT_SCHEMA=[EsquemaAppA, EsquemaAppB]
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datareader', N'administracion'
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datawriter', N'administracion'
GO

/*
Punto 3 
*/

USE [master]
GO
CREATE LOGIN [RRHH] WITH PASSWORD=N'123456', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BaseDeDatosHR]
GO
CREATE USER [RRHH] FOR LOGIN [RRHH]
GO
USE [BaseDeDatosHR]
GO
ALTER USER [RRHH] WITH DEFAULT_SCHEMA=[EsquemaAppB]
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datareader', N'RRHH'
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datawriter', N'RRHH'
GO

/* 
Punto 4 
*/


USE [master]
GO
CREATE LOGIN [IT] WITH PASSWORD=N'123456', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BaseDeDatosDesarrollo]
GO
CREATE USER [IT] FOR LOGIN [IT]
GO
USE [BaseDeDatosDesarrollo]
GO
EXEC sp_addrolemember N'db_datawriter', N'IT'
GO
USE [BaseDeDatosHR]
GO
CREATE USER [IT] FOR LOGIN [IT]
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datawriter', N'IT'
GO
USE [BaseDeDatosDesarrollo]
GO
DENY ALTER ON [EsquemaAppB].[tabla2] TO [IT]
GO
use [BaseDeDatosDesarrollo]
GO
DENY ALTER ON [EsquemaAppA].[tabla2] TO [IT]
GO
use [BaseDeDatosDesarrollo]
GO
DENY ALTER ON [EsquemaAppA].[tabla1] TO [IT]
GO
use [BaseDeDatosDesarrollo]
GO
DENY ALTER ON [EsquemaAppB].[tabla1] TO [IT]
GO

/*
Punto 5 
*/

USE [master]
GO
CREATE LOGIN [desarrollo] WITH PASSWORD=N'123456', DEFAULT_DATABASE=[master], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE [BaseDeDatosDesarrollo]
GO
CREATE USER [desarrollo] FOR LOGIN [desarrollo]
GO
USE [BaseDeDatosHR]
GO
CREATE USER [desarrollo] FOR LOGIN [desarrollo]
GO
USE [BaseDeDatosHR]
GO
ALTER USER [desarrollo] WITH DEFAULT_SCHEMA=[EsquemaAppB.tabla2]
GO
USE [BaseDeDatosHR]
GO
EXEC sp_addrolemember N'db_datareader', N'desarrollo'
GO
use [BaseDeDatosDesarrollo]
GO
GRANT DELETE ON [EsquemaAppB].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT INSERT ON [EsquemaAppB].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT ALTER ON [EsquemaAppB].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT DELETE ON [EsquemaAppA].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT INSERT ON [EsquemaAppA].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT ALTER ON [EsquemaAppA].[tabla2] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT DELETE ON [EsquemaAppA].[tabla1] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT INSERT ON [EsquemaAppA].[tabla1] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT ALTER ON [EsquemaAppA].[tabla1] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT DELETE ON [EsquemaAppB].[tabla1] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT INSERT ON [EsquemaAppB].[tabla1] TO [desarrollo]
GO
use [BaseDeDatosDesarrollo]
GO
GRANT ALTER ON [EsquemaAppB].[tabla1] TO [desarrollo]
GO
