Use master
Go

If Not Exists
 (
   select [name]
   from sys.databases
   where [name] = 'Gimnasios_Proyecto'
 )
 Create Database Gimnasios_Proyecto
 Go

 Use Gimnasios_Proyecto
 Go

 
IF OBJECT_ID('[dbo].[RutinaxEjercicio]', 'U') IS NOT NULL
DROP TABLE [dbo].[RutinaxEjercicio]
GO

IF OBJECT_ID('[dbo].[Reporte]', 'U') IS NOT NULL
DROP TABLE [dbo].[Reporte]
GO

IF OBJECT_ID('[dbo].[Mediciones]', 'U') IS NOT NULL
DROP TABLE [dbo].[Mediciones]
GO

IF OBJECT_ID('[dbo].[Rutina]', 'U') IS NOT NULL
DROP TABLE [dbo].[Rutina]
GO

IF OBJECT_ID('[dbo].[Clientes]', 'U') IS NOT NULL
DROP TABLE [dbo].[Clientes]
GO

IF OBJECT_ID('[dbo].[Instructores]', 'U') IS NOT NULL
DROP TABLE [dbo].[Instructores]
GO

IF OBJECT_ID('[dbo].[Funcionarios_administrativos]', 'U') IS NOT NULL
DROP TABLE [dbo].[Funcionarios_administrativos]
GO

IF OBJECT_ID('[dbo].[Personal]', 'U') IS NOT NULL
DROP TABLE [dbo].[Personal]
GO

IF OBJECT_ID('[dbo].[GimnasioxSede]', 'U') IS NOT NULL
DROP TABLE [dbo].[GimnasioxSede]
GO

IF OBJECT_ID('[dbo].[Ejercicios]', 'U') IS NOT NULL
DROP TABLE [dbo].[Ejercicios]
GO

IF OBJECT_ID('[dbo].[Gimnasio]', 'U') IS NOT NULL
DROP TABLE [dbo].[Gimnasio]
GO

IF OBJECT_ID('[dbo].[Sede]', 'U') IS NOT NULL
DROP TABLE [dbo].[Sede]
GO


--Tabla Gimnasio
Create table [dbo].[Gimnasio]
(
   Id_gimnasio int not null Primary key,
   Nombre_gym varchar(45) not null,
   Codigo_gym int  not null,
   Tel_gym varchar(45) not null,
   Contacto_gym varchar(45) not null
)
Go

--Tabla Sede
Create table [dbo].[Sede]
(
   Id_sede int not null Primary key,
   Nombre_sede varchar(45) not null,
   Provincia_sede varchar(45)   not null,
   Canton_sede varchar(45) not null,
   Correo_sede varchar(45) not null,
   Telefono varchar(45) not null,
)
Go

--Tabla GimnasioxSede
CREATE TABLE  [dbo].[GimnasioxSede]
(
    Id_gimnasio int not null,
    Id_sede int not null,
	CONSTRAINT PK_GimnasioxSede Primary key (Id_gimnasio,Id_sede)
   ,CONSTRAINT FK_GimnasioxSede_Gym Foreign key (Id_gimnasio) 
    REFERENCES Gimnasio (Id_gimnasio)
   ,CONSTRAINT FK_GimnasioxSede_Sede Foreign key (Id_sede)
    REFERENCES Sede (Id_sede)
);


--Tabla Personal
Create table [dbo].[Personal]
(
   Id_personal int not null Primary key,
   Id_sede int not null,
   Nombre_completo varchar(45) not null,
   Telefono varchar(45)  not null,
   Correo varchar(45) not null,
   Fecha_nacimiento date not null,
   Salario decimal not null,
   CONSTRAINT FK_Sede Foreign key (Id_sede)
    REFERENCES Sede (Id_sede)
  
)
Go

--Tabla Funcionarios_Administrativos
Create table [dbo].[Funcionarios_administrativos]
(
   Puesto varchar(100) not null,
   Id_personal int not null,
   Id_sede int not null,
   CONSTRAINT FK_Funcionarios_Personal Foreign key (Id_personal)
    REFERENCES Personal (Id_personal),
   CONSTRAINT FK_Funcionarios_Sede Foreign key (Id_sede)
    REFERENCES Sede (Id_sede)
)
Go

--Instructores
Create table [dbo].[Instructores]
(
   Certificaciones varchar(1000),
   Id_personal int not null Primary key,
   Id_sede int not null,
   CONSTRAINT FK_Instructores_Personal Foreign key (Id_personal)
    REFERENCES Personal (Id_personal),
   CONSTRAINT FK_Instructores_Sede Foreign key (Id_sede)
    REFERENCES Sede (Id_sede)
)
Go

--Tabla Clientes
Create table [dbo].[Clientes]
(
   Id_clientes int not null Primary key,
   Id_instructores int not null,
   Nombre_completo varchar(45) not null,
   Telefono varchar(45)  not null,
   Correo varchar(45) not null,
   Fecha_nacimiento date not null,
   Sexo varchar(45) not null,
   Riesgo varchar(45) not null,
   Id_sede_instructor int not null,
   CONSTRAINT FK_Clientes_Instructores FOREIGN KEY (Id_instructores)
      REFERENCES Instructores (Id_personal)
)
Go

--Tabla Rutina
Create table [dbo].[Rutina]
(
   Id_rutina int not null Primary key,
   Id_clientes int not null,
   Fecha_inicial date not null,
   Fecha_final date not null,
   CONSTRAINT FK_Rutina_Clientes Foreign key (Id_clientes)
    REFERENCES Clientes (Id_clientes),

)
Go

--Tabla Ejercicios
Create table [dbo].[Ejercicios]
(
   Id_ejercicios int not null Primary key,
   Nombre_ejercicio varchar(45) not null,
   Zona_muscular varchar(45)  not null
)
Go

--Tabla RutinaxEjercicios
CREATE TABLE  [dbo].[RutinaxEjercicio]
(
    Id_rutina int not null,
    Id_ejercicios int not null,
	CONSTRAINT PK_RutinaxEjercicio Primary key (Id_rutina,Id_ejercicios)
   ,CONSTRAINT FK_RutinaxEjercicio_Rutina Foreign key (Id_rutina) 
    REFERENCES Rutina (Id_rutina)
   ,CONSTRAINT RutinaxEjercicio_Ejercicio Foreign key (Id_ejercicios)
    REFERENCES Ejercicios (Id_ejercicios)
   
);

--Tabla Mediciones
Create table [dbo].[Mediciones]
(
   Id_mediciones int not null Primary key,
   Id_clientes int not null,
   Horayfecha datetime not null,
   Peso float  not null,
   Porcentaje_grasa float not null,
   Porcentaje_musc float not null,
   Edad_metab float not null,
   Porcen_grasa_visceral varchar(45) not null,
   Estatura int not null
   ,CONSTRAINT Mediciones_clientes Foreign key (Id_clientes)
    REFERENCES Clientes (Id_clientes)
)
Go

--Tabla Reporte
Create table [dbo].[Reporte]
(
   Id_reporte int not null Primary key,
   Id_mediciones int not null,
   IMC float  not null,
   Cantidad_proteina varchar(200) not null,
   Cantidad_agua float not null,
   Clasificacion_IMC varchar(45) not null
   ,CONSTRAINT Reporte_mediciones Foreign key (Id_mediciones)
    REFERENCES Mediciones (Id_mediciones)
)
Go



                                                  ---CRUDS---

 --Gimnasio
  ---Insertar Gimnasio---
CREATE OR ALTER PROCEDURE Insertar_gimnasios
(
  @Id_gimnasio int, 
  @Nombre_gym nvarchar(45), 
  @Codigo_gym int, 
  @Tel_gym varchar(45),
  @Contacto_gym varchar(45)
)
AS
BEGIN
       INSERT INTO Gimnasio(Id_gimnasio ,Nombre_gym,Codigo_gym,Tel_gym,Contacto_gym)
	   VALUES (@Id_gimnasio,@Nombre_gym,@Codigo_gym,@Tel_gym,@Contacto_gym)
END
GO
 
  --Modficar Gimnasio--
CREATE OR ALTER PROCEDURE Modificar_gimnasio
(
  @Id_gimnasio int, 
  @Nombre_gym nvarchar(45), 
  @Codigo_gym int, 
  @Tel_gym varchar(45),
  @Contacto_gym varchar(45)
)
AS
BEGIN
    UPDATE Gimnasio 
	  SET Gimnasio.Id_gimnasio=@Id_gimnasio,
	       Gimnasio.Nombre_gym=@Nombre_gym, 
		   Gimnasio.Codigo_gym=@Codigo_gym,
		   Gimnasio.Tel_gym=@Tel_gym,
		   Gimnasio.Contacto_gym=@Contacto_gym
      WHERE Gimnasio.Id_gimnasio=@Id_gimnasio
END
GO
   --Eliminar Gimnasio--
CREATE OR ALTER PROCEDURE Eliminar_gimnasio
(
 @Id_gimnasio int
)
AS
BEGIN
    DELETE FROM Gimnasio WHERE Gimnasio.Id_gimnasio = @Id_gimnasio
END
GO

  --Consultar un Gimnasio--
CREATE OR ALTER FUNCTION Consulta_gimnasio
(@Id_gimnasio int)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Gimnasio WHERE Id_gimnasio= @Id_gimnasio
)
GO

   --Listado de Gimnasios--
Create or Alter  Function Listado_gimnasio
()
Returns Table
As
Return
(
 Select  Gimnasio.Id_gimnasio,  Gimnasio.Nombre_gym, Gimnasio.Codigo_gym,Gimnasio.Tel_gym,Gimnasio.Contacto_gym
 FROM dbo.Gimnasio
 )
Go

--Pruebas Gimnasio
  --Procedures
  Exec Insertar_gimnasios 001,'Prueba',1,'2228-9076','Smartfit@gmail.com';
  Exec Eliminar_gimnasio 1;
  Exec Insertar_gimnasios 001,'Smart Fit',1,'2520-3267','Smartfit@gmail.com'
  Exec Insertar_gimnasios 002,'SCrunch Fitness',2,'25101-367','CrunchFitness@gmail.com';
  Exec Insertar_gimnasios 003,'FYM Gym',3,'2210-9089','Fimgym@gmail.com';
  Exec Insertar_gimnasios 004,'Gold Arena',4,'2910-2324','Goldarena@gmail.com';
  Exec Insertar_gimnasios 005,'Bio Fit',5,'2940-5060','Biofit@gmail.com';
  Exec Modificar_gimnasio 002,'Crunch Fitness',2,'25101-367','CrunchFitness@gmail.com';
  
  --Funciones
  Select * From Consulta_gimnasio(001);
  Select * From Listado_gimnasio();

--Sede
  ---Insertar Sede---
CREATE OR ALTER PROCEDURE Insertar_sede
(
    @Id_sede int,
    @Nombre_sede varchar(45),
    @Provincia_sede varchar(45),
    @Canton_sede varchar(45),
    @Correo_sede varchar(45),
    @Telefono varchar(45)
)
AS
BEGIN
    INSERT INTO Sede(Id_sede, Nombre_sede, Provincia_sede, Canton_sede, Correo_sede, Telefono)
    VALUES (@Id_sede, @Nombre_sede, @Provincia_sede, @Canton_sede, @Correo_sede, @Telefono)
END
GO
   ---Modificar Sede---
CREATE OR ALTER PROCEDURE Modificar_sede
(
    @Id_sede int,
    @Nombre_sede varchar(45),
    @Provincia_sede varchar(45),
    @Canton_sede varchar(45),
    @Correo_sede varchar(45),
    @Telefono varchar(45)
)
AS
BEGIN
    UPDATE Sede
    SET Nombre_sede = @Nombre_sede,
        Provincia_sede = @Provincia_sede,
        Canton_sede = @Canton_sede,
        Correo_sede = @Correo_sede,
        Telefono = @Telefono
    WHERE Id_sede = @Id_sede;
END
GO

 ---Eliminar Sede---
 CREATE OR ALTER PROCEDURE Eliminar_sede
(
    @Id_sede int
)
AS
BEGIN
    DELETE FROM Sede WHERE Id_sede = @Id_sede;
END
GO

 ---Consultar Sede---
 CREATE OR ALTER FUNCTION Consultar_sede
(
 @Id_sede int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Sede WHERE Id_sede = @Id_sede
)
GO

 ---Listar Sede---
 CREATE OR ALTER FUNCTION Listar_sede
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_sede, Nombre_sede, Provincia_sede, Canton_sede, Correo_sede, Telefono 
	FROM dbo.Sede
)
GO
--Pruebas
  --Sede
Exec Insertar_sede 1,'Sede Central','San Jose','San Jose','Smartfitcentral@gmail.com','2520-3267';
Exec Eliminar_sede 1;
Exec Insertar_sede 1,'Sede Central','San Jose','San Jose','Smartfitcentral@gmail.com','2520-3267';
Exec Insertar_sede 2,'Sede  Sur','San Jose',' Heredia','Smartfitsur@gmail.com','2520-3267';
Exec Modificar_sede 2,'Sede Heredia','San Jose','Heredia','CrunchFitness@gmail.com','2510-2324';
Exec Insertar_sede 3,'Sede Central','San Jose','Desamparados ','Fimgym@gmail.com','2510-9089';
Exec Insertar_sede 4,'Sede Norte ','San Jose',' San Jose','Crunchfitness@gmail.com','2510-1367';
Exec Insertar_sede 5,'Sede Central','San Jose',' Heredia','Goldarena@gmail.com','2910-2324';
  --Funciones
  Select * From Consultar_sede(1);
  Select * From Listar_sede();

--GimnasioxSede
 --Insertar GimnasioxSede--
 CREATE OR ALTER PROCEDURE Insertar_gimnasio_sede
(
    @Id_gimnasio int,
    @Id_sede int
)
AS
BEGIN
    INSERT INTO GimnasioxSede(Id_gimnasio, Id_sede)
    VALUES (@Id_gimnasio, @Id_sede);
END
GO

 --Eliminar Gimnasio Sede--
 CREATE OR ALTER PROCEDURE Eliminar_gimnasio_sede
(
    @Id_gimnasio int,
    @Id_sede int
)
AS
BEGIN
    DELETE FROM GimnasioxSede
    WHERE Id_gimnasio = @Id_gimnasio AND Id_sede = @Id_sede;
END
GO
 
 --Consultar Gimnsasio Sede--
 CREATE OR ALTER FUNCTION Consulta_gimnasio_sede
(
  @Id_gimnasio int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM GimnasioxSede
	WHERE Id_gimnasio = @Id_gimnasio
)
GO

 --Listar Gimnasio Sede--
CREATE OR ALTER FUNCTION Listar_gimnasio_sede
()
RETURNS TABLE
AS
RETURN
(
    SELECT GXS.Id_gimnasio, Gimnasio.Nombre_gym,GXS.Id_sede,Sede.Nombre_sede 
	FROM GimnasioxSede as GXS
	JOIN Sede ON Sede.Id_sede = GXS.Id_sede
	JOIN Gimnasio ON Gimnasio.Id_gimnasio = GXS.Id_gimnasio
)
GO

--Pruebas GimnasioxSede
 --Procedures
 Exec Insertar_gimnasio_sede 1,3;
 Exec Eliminar_gimnasio_sede 1,2;
  Exec Insertar_gimnasio_sede 1,1;
  Exec Insertar_gimnasio_sede 2,2;
   Exec Insertar_gimnasio_sede 3,3;
    Exec Insertar_gimnasio_sede 4,4;
	 Exec Insertar_gimnasio_sede 5,5;


  --Funciones
  Select * From Consulta_gimnasio_sede(2)
  Select * From Listar_gimnasio_sede();

--Personal--
 --Insertar Personal--
CREATE OR ALTER PROCEDURE Insertar_personal
(
  @Id_personal int, 
  @Id_sede int, 
  @Nombre_completo varchar(45), 
  @Telefono varchar(45),
  @Correo varchar(45),
  @Fecha_nacimiento date,
  @Salario decimal
)
AS
BEGIN
    INSERT INTO Personal(Id_personal, Id_sede, Nombre_completo, Telefono, Correo, Fecha_nacimiento, Salario)
    VALUES (@Id_personal, @Id_sede, @Nombre_completo, @Telefono, @Correo, @Fecha_nacimiento, @Salario)
END
GO

 --Modificar Personal--
CREATE OR ALTER PROCEDURE Modificar_personal
(
  @Id_personal int, 
  @Id_sede int, 
  @Nombre_completo varchar(45), 
  @Telefono varchar(45),
  @Correo varchar(45),
  @Fecha_nacimiento date,
  @Salario decimal
)
AS
BEGIN
    UPDATE Personal 
    SET 
        Id_sede = @Id_sede,
        Nombre_completo = @Nombre_completo, 
        Telefono = @Telefono,
        Correo = @Correo,
        Fecha_nacimiento = @Fecha_nacimiento,
        Salario = @Salario
    WHERE Id_personal = @Id_personal
END
GO

 --Eliminar Personal--
CREATE OR ALTER PROCEDURE Eliminar_personal
(
  @Id_personal int
)
AS
BEGIN
    DELETE FROM Personal WHERE Id_personal = @Id_personal
END
GO

 --Consultar Personal--
CREATE OR ALTER FUNCTION Consulta_personal
(
  @Id_personal int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Personal WHERE Id_personal = @Id_personal
)
GO

 --Listar Personal
CREATE OR ALTER FUNCTION Listar_personal
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_personal, Id_sede, Nombre_completo, Telefono, Correo, Fecha_nacimiento, Salario
    FROM dbo.Personal
)
GO

--Pruebas Personal--
 --Procedures--
 Exec Insertar_personal 207630033,1,'Ana Maria Gonzales','8533-9273','ana@gmail.com','07-01-97',500.000;
  Exec Insertar_personal 2055550033,1,'Palbo  Gonzales','8384-9273','pablo@gmail.com','08-21-00',600.000;
  Exec Modificar_personal 2055550033,1,'Juan Pablo  Gonzales','8384-9273','pablo@gmail.com','01-02-97',600.000;
  Exec Insertar_personal 1055550033,1,'Franco  Reyes','8824-1283','franco@gmail.com','09-09-88',800.000;
  Exec Insertar_personal 1030800033,1,'Jimena  Elizondo','8384-9273','jimnea@gmail.com','04-08-98',900.000;
  Exec Insertar_personal 1040800033,1,'Norma Elizondo','8384-9273','jimnea@gmail.com','04-08-98',900.000;
  Exec Insertar_personal 1091200033,1,'Norma Elizondo','8384-9273','jimnea@gmail.com','04-08-98',900.000;
  Exec Insertar_personal 1201200033,1,'Juan','8584-9273','j@gmail.com','04-08-98',900.000;
  Exec Insertar_personal 1001200033,1,'Pedro','8581-9273','p@gmail.com','04-08-99',900.000;
  Exec Insertar_personal 1011200033,1,'Gato','8521-9273','g@gmail.com','04-08-89',900.000;


  Exec Eliminar_personal 1040800033;

  --Fuciones
  Select * From Consulta_personal(2055550033);
  Select * From Listar_personal();

--Funcionarios Administrativos
---Insertar Funcionarios Adiministrativos---
CREATE OR ALTER PROCEDURE Insertar_funcionario_administrativo
(
  @Puesto varchar(100), 
  @Id_personal int, 
  @Id_sede int
)
AS
BEGIN
    INSERT INTO Funcionarios_administrativos(Puesto, Id_personal, Id_sede)
    VALUES (@Puesto, @Id_personal, @Id_sede)
END
GO

   ---Modificar funcionario_administrativo---
CREATE OR ALTER PROCEDURE Modificar_funcionario_administrativo
(
 @Puesto varchar(100),
  @Id_personal int, 
  @Id_sede int
  
)
AS
BEGIN
    UPDATE Funcionarios_administrativos 
    SET 
	    Puesto = @Puesto,
        Id_personal = @Id_personal,
        Id_sede = @Id_sede
    WHERE Id_personal= @Id_personal
END
GO


 ---Eliminar funcionario_administrativo ---
CREATE OR ALTER PROCEDURE Eliminar_funcionario_administrativo
(
  @Idpersonal int
)
AS
BEGIN
    DELETE FROM Funcionarios_administrativos WHERE Id_personal = @Idpersonal
END
GO

--Consultar Funcionario administrativo--
CREATE OR ALTER FUNCTION Consulta_funcionario_administrativo
(
  @Puesto varchar(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Funcionarios_administrativos WHERE Puesto = @Puesto
)
GO

 ---Listar Funcionarios Administrativos---
CREATE OR ALTER FUNCTION Listado_funcionario_administrativo
()
RETURNS TABLE
AS
RETURN
(
    SELECT Puesto, Funcionarios_administrativos.Id_personal, Personal.Nombre_completo, Funcionarios_administrativos.Id_sede, Sede.Nombre_sede 
    FROM dbo.Funcionarios_administrativos
	JOIN dbo.Personal ON Personal.Id_personal=Funcionarios_administrativos.Id_personal
	JOIN dbo.Sede ON Sede.Id_sede=Funcionarios_administrativos.Id_sede
	
)
GO

-- Pruebas Funcionarios Administrativos --
-- Procedures --
EXEC Insertar_funcionario_administrativo 'Gerente', 207630033, 1;
EXEC Insertar_funcionario_administrativo 'Asistente', 2055550033, 1;
EXEC Modificar_funcionario_administrativo 'Coordinador', 2055550033,2;
EXEC Insertar_funcionario_administrativo 'Admin', 1055550033, 1;
EXEC Insertar_funcionario_administrativo 'Admin', 1030800033, 1;
EXEC Insertar_funcionario_administrativo 'Conserje', 1091200033, 1;
EXEC Modificar_funcionario_administrativo 'Recpcionista', 1055550033,3;
EXEC Modificar_funcionario_administrativo 'Secretario', 1030800033,4;
EXEC Eliminar_funcionario_administrativo 207630033;

-- Funciones --
SELECT * FROM Consulta_funcionario_administrativo('Admin');
SELECT * FROM Listado_funcionario_administrativo();



--Instructores
---Insertar Instructores---
CREATE OR ALTER PROCEDURE Insertar_instructor
(
  @Certificaciones varchar(1000), 
  @Id_personal int, 
  @Id_sede int
)
AS
BEGIN
    INSERT INTO Instructores(Certificaciones, Id_personal, Id_sede)
    VALUES (@Certificaciones, @Id_personal, @Id_sede)
END
GO


   ---Modificar Instructor---
CREATE OR ALTER PROCEDURE Modificar_instructor
(
  @Certificaciones varchar(1000), 
  @Id_personal int, 
  @Id_sede int
)
AS
BEGIN
    UPDATE Instructores 
    SET 
        Id_personal = @Id_personal,
        Id_sede = @Id_sede,
		Certificaciones = @Certificaciones
    WHERE  Id_personal = @Id_personal
END
GO

 ---Eliminar Instructor ---
CREATE OR ALTER PROCEDURE Eliminar_instructor
(
  @Id_personal int
)
AS
BEGIN
    DELETE FROM Instructores WHERE Id_personal = @Id_personal
END
GO


--Consultar Instructor--
CREATE OR ALTER FUNCTION Consulta_instructor
(
  @Id_personal int
)
RETURNS TABLE
AS
RETURN
(
    SELECT  Instructores.Id_personal as Id_Instructor,Nombre_completo as Nombre_Instructor, Instructores.Id_sede,Nombre_sede as Sede,Certificaciones
    FROM dbo.Instructores
	JOIN dbo.Sede ON Instructores.Id_sede = Sede.Id_sede 
    JOIN dbo.Personal ON Instructores.Id_personal = Personal.Id_personal 
	WHERE Instructores.Id_personal = @Id_personal
)
GO


 ---Listar Instructores---
CREATE OR ALTER FUNCTION Listar_instructores
()
RETURNS TABLE
AS
RETURN
(
    SELECT  Instructores.Id_personal as Id_Instructor,Nombre_completo as Nombre_Instructor, Instructores.Id_sede,Nombre_sede as Sede,Certificaciones
    FROM dbo.Instructores
	JOIN dbo.Sede ON Instructores.Id_sede = Sede.Id_sede 
    JOIN dbo.Personal ON Instructores.Id_personal = Personal.Id_personal 
)
GO

-- Pruebas Instructores --
-- Procedures --
EXEC Insertar_instructor 'Cert1, Cert2', 1011200033, 1;
EXEC Insertar_instructor 'Cert3, Cert4', 1001200033, 1;
EXEC Modificar_instructor 'Cert3, Cert4', 1001200033, 2;
EXEC Insertar_instructor 'Cert5, Cert6', 1201200033, 1;

EXEC Eliminar_instructor 1201200033;

-- Funciones --
SELECT * FROM Consulta_instructor(1001200033);
SELECT * FROM Listar_instructores();

--Clientes
---Insertar Cliente---
CREATE OR ALTER PROCEDURE Insertar_cliente
(
  @Id_clientes int, 
  @Id_instructores int, 
  @Nombre_completo varchar(45), 
  @Telefono varchar(45),
  @Correo varchar(45),
  @Fecha_nacimiento date,
  @Sexo varchar(45),
  @Riesgo varchar(45),
  @Id_sede_instructor int
)
AS
BEGIN
    INSERT INTO Clientes(Id_clientes, Id_instructores, Nombre_completo, Telefono, Correo, Fecha_nacimiento, Sexo, Riesgo, Id_sede_instructor)
    VALUES (@Id_clientes, @Id_instructores, @Nombre_completo, @Telefono, @Correo, @Fecha_nacimiento, @Sexo, @Riesgo, @Id_sede_instructor)
END
GO



   ---Modificar Cliente---
CREATE OR ALTER PROCEDURE Modificar_cliente
(
  @Id_clientes int, 
  @Id_instructores int, 
  @Nombre_completo varchar(45), 
  @Telefono varchar(45),
  @Correo varchar(45),
  @Fecha_nacimiento date,
  @Sexo varchar(45),
  @Riesgo varchar(45),
  @Id_sede_instructor int
)
AS
BEGIN
    UPDATE Clientes 
    SET 
        Id_instructores = @Id_instructores,
        Nombre_completo = @Nombre_completo, 
        Telefono = @Telefono,
        Correo = @Correo,
        Fecha_nacimiento = @Fecha_nacimiento,
        Sexo = @Sexo,
        Riesgo = @Riesgo,
        Id_sede_instructor = @Id_sede_instructor
    WHERE Id_clientes = @Id_clientes
END
GO


 ---Eliminar Cliente ---
CREATE OR ALTER PROCEDURE Eliminar_cliente
(
  @Id_clientes int
)
AS
BEGIN
    DELETE FROM Clientes WHERE Id_clientes = @Id_clientes
END
GO
--Consultar Cliente--
CREATE OR ALTER FUNCTION Consulta_cliente
(
  @Id_clientes int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Clientes WHERE Id_clientes = @Id_clientes
)
GO
 ---Listar Clientes---
CREATE OR ALTER FUNCTION Listado_cliente
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_clientes, Id_instructores,Personal.Nombre_completo as Nombre_Instructor, Clientes.Telefono, Clientes.Correo, Clientes.Fecha_nacimiento, Sexo, Riesgo, Id_sede_instructor, Sede.Nombre_sede
    FROM dbo.Clientes
	JOIN dbo.Instructores ON Instructores.Id_personal=Clientes.Id_instructores
	JOIN dbo.Sede ON Sede.Id_sede=Clientes.Id_sede_instructor
	JOIN dbo.Personal ON Personal.Id_personal=Instructores.Id_personal
	)
GO

-- Pruebas Clientes --
-- Procedures --
EXEC Insertar_cliente 301, 1001200033, 'Cliente1', '123-4567', 'cliente1@email.com', '1990-01-01', 'Femenino', 'Bajo', 2;
EXEC Insertar_cliente 302, 1011200033, 'Cliente2', '987-6543', 'cliente2@email.com', '1985-05-15', 'Masculino', 'Medio', 1;
EXEC Modificar_cliente 301, 1011200033, 'Cliente sin papas', '555-1234', 'cliente1_modificado@email.com', '1990-01-01', 'Femenino', 'Alto', 1;
EXEC Insertar_cliente 303, 1001200033, 'Cliente3', '333-3333', 'cliente3@email.com', '2000-12-31', 'Masculino', 'Bajo', 2;
EXEC Insertar_cliente 304, 1011200033, 'Cliente4', '444-4444', 'cliente4@email.com', '1995-08-20', 'Femenino', 'Medio', 1;
EXEC Insertar_cliente 305, 1001200033, 'Cliente5', '555-5555', 'cliente5@email.com', '1988-06-15', 'Masculino', 'Bajo', 2;

EXEC Eliminar_cliente 303;

-- Funciones --
SELECT * FROM Consulta_cliente(301);
SELECT * FROM Listado_cliente();


--Rutina
---Insertar Rutina---
CREATE OR ALTER PROCEDURE Insertar_rutina
(
  @Id_rutina int, 
  @Id_clientes int, 
  @Fecha_inicial date 
  
)
AS
BEGIN
    DECLARE @Fecha_final date; 
    SET @Fecha_final = DATEADD(Month, 3, @Fecha_inicial);
    INSERT INTO Rutina(Id_rutina, Id_clientes, Fecha_inicial,Fecha_final)
    VALUES (@Id_rutina, @Id_clientes, @Fecha_inicial,@Fecha_final)
END
GO
   ---Modificar Rutina---
CREATE OR ALTER PROCEDURE Modificar_rutina
(
  @Id_rutina int, 
  @Id_clientes int, 
  @Fecha_inicial date
)
AS
BEGIN
    DECLARE @Fecha_final date; 
    SET @Fecha_final = DATEADD(Month, 3, @Fecha_inicial);
    UPDATE Rutina 
    SET 
        Id_clientes = @Id_clientes,
        Fecha_inicial = @Fecha_inicial,
        Fecha_final = @Fecha_final
    WHERE Id_rutina = @Id_rutina
END
Go

 ---Eliminar Rutina ---
CREATE OR ALTER PROCEDURE Eliminar_rutina
(
  @Id_rutina int
)
AS
BEGIN
    DELETE FROM Rutina WHERE Id_rutina = @Id_rutina
END
GO
--Consultar Rutina--
CREATE OR ALTER FUNCTION Consulta_rutina
(
  @Id_rutina int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Rutina WHERE Id_rutina = @Id_rutina
)
GO

 ---Listar Rutinas---
CREATE OR ALTER FUNCTION Listar_rutinas
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_rutina, Rutina.Id_clientes, Clientes.Nombre_completo as Nombre_del_Cliente, Fecha_inicial, Fecha_final
    FROM dbo.Rutina
	JOIN dbo.Clientes ON Clientes.Id_clientes=Rutina.Id_clientes
)
GO
-- Pruebas Rutina --
-- Procedures --
EXEC Insertar_rutina 501, 301, '2023-01-01';
EXEC Insertar_rutina 502, 302, '2023-02-01';
EXEC Insertar_rutina 503, 302, '2023-02-01';
EXEC Modificar_rutina 501, 302, '2023-01-01';
EXEC Insertar_rutina 504, 304, '2023-04-01';
EXEC Insertar_rutina 505, 305, '2023-05-01';

EXEC Eliminar_rutina 503;

-- Funciones --
SELECT * FROM Consulta_rutina(501);
SELECT * FROM Listar_rutinas();

--Ejercicio
---Insertar Ejercicio---
CREATE OR ALTER PROCEDURE Insertar_ejercicio
(
  @Id_ejercicios int, 
  @Nombre_ejercicio varchar(45), 
  @Zona_muscular varchar(45)
)
AS
BEGIN
    INSERT INTO Ejercicios(Id_ejercicios, Nombre_ejercicio, Zona_muscular)
    VALUES (@Id_ejercicios, @Nombre_ejercicio, @Zona_muscular)
END
GO

   ---Modificar Ejercicio---
CREATE OR ALTER PROCEDURE Modificar_ejercicio
(
  @Id_ejercicios int, 
  @Nombre_ejercicio varchar(45), 
  @Zona_muscular varchar(45)
)
AS
BEGIN
    UPDATE Ejercicios 
    SET 
        Nombre_ejercicio = @Nombre_ejercicio,
        Zona_muscular = @Zona_muscular
    WHERE Id_ejercicios = @Id_ejercicios
END
GO

 ---Eliminar Ejercicio ---
CREATE OR ALTER PROCEDURE Eliminar_ejercicio
(
  @Id_ejercicios int
)
AS
BEGIN
    DELETE FROM Ejercicios WHERE Id_ejercicios = @Id_ejercicios
END
GO

--Consultar Ejercicio--
CREATE OR ALTER FUNCTION Consulta_ejercicio
(
  @Id_ejercicios int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Ejercicios WHERE Id_ejercicios = @Id_ejercicios
)
GO

 ---Listar Ejercicios---
CREATE OR ALTER FUNCTION Listar_ejercicios
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_ejercicios, Nombre_ejercicio, Zona_muscular
    FROM dbo.Ejercicios
)
GO


-- Pruebas Ejercicios --
-- Procedures --

EXEC Insertar_ejercicio 1, 'Press de Banca', 'Pecho';
EXEC Insertar_ejercicio 2, 'Dominadas', 'Espalda';
EXEC Insertar_ejercicio 3, 'Curl de Bíceps', 'Brazos';
EXEC Insertar_ejercicio 4, 'Crunches', 'Abdomen';
EXEC Insertar_ejercicio 5, 'Sentadillas', 'Muslo';
EXEC Insertar_ejercicio 6, 'Flexiones', 'Pecho';
EXEC Insertar_ejercicio 7, 'Peso Muerto', 'Espalda';
EXEC Insertar_ejercicio 8, 'Tríceps en polea', 'Brazos';
EXEC Insertar_ejercicio 9, 'Plancha', 'Abdomen';
EXEC Insertar_ejercicio 10, 'Zancadas', 'Muslo';
EXEC Insertar_ejercicio 11, 'Pull-ups', 'Espalda';
EXEC Insertar_ejercicio 12, 'Fondos en paralelas', 'Tríceps';
EXEC Insertar_ejercicio 13, 'Deadlift', 'Espalda';
EXEC Insertar_ejercicio 14, 'Burpees', 'Cuerpo completo';
EXEC Insertar_ejercicio 15, 'Mountain climbers', 'Abdomen';
EXEC Insertar_ejercicio 16, 'Leg press', 'Muslo';
EXEC Insertar_ejercicio 17, 'Shoulder press', 'Hombros';
EXEC Insertar_ejercicio 18, 'Russian twists', 'Abdomen';
EXEC Insertar_ejercicio 19, 'Lunges', 'Muslo';
EXEC Insertar_ejercicio 20, 'Bicep curls', 'Brazos';

EXEC Modificar_ejercicio 1, 'Press de Banca Modificado', 'Pecho';
EXEC Eliminar_ejercicio 2;

-- Funciones --
SELECT * FROM Consulta_ejercicio(1);
SELECT * FROM Listar_ejercicios();


--RutinaxEjercicio
---Insertar RutinaxEjercicio ---
CREATE OR ALTER PROCEDURE Insertar_Rutina_Ejercicio
(
    @IdRutina int,
    @IdEjercicio int
)
AS
BEGIN
    INSERT INTO RutinaxEjercicio (Id_rutina, Id_ejercicios)
    VALUES (@IdRutina, @IdEjercicio);
END;
GO

   ---Modificar Rutina_Ejercicio---
CREATE OR ALTER PROCEDURE Modificar_Rutina_Ejercicio
(
    @IdRutina int,
    @IdEjercicio int,
	@Id_ejercicioN int
)
AS
BEGIN
    UPDATE RutinaxEjercicio
    SET Id_ejercicios = @Id_ejercicioN
    WHERE Id_rutina = @IdRutina and Id_ejercicios = @IdEjercicio
END;
GO

 ---Eliminar Rutina_Ejercicio ---
CREATE OR ALTER PROCEDURE Eliminar_Rutina_Ejercicio
(
    @IdRutina int,
    @IdEjercicio int
)
AS
BEGIN
    DELETE FROM RutinaxEjercicio
    WHERE Id_rutina = @IdRutina AND Id_ejercicios = @IdEjercicio;
END;
GO

--Consultar Ejercicio--
CREATE OR ALTER FUNCTION Consultar_Ejercicio_Rutina
(
    @IdRutina int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * From RutinaxEjercicio
    WHERE Id_rutina = @IdRutina
);
GO

 ---Listar Ejercicios---
CREATE OR ALTER FUNCTION Listar_Ejercicios_Por_Rutinas()
RETURNS TABLE
AS
RETURN
(
    SELECT 
        RutinaxEjercicio.Id_rutina, 
        RutinaxEjercicio.Id_ejercicios,
        Ejercicios.Nombre_ejercicio,
        Ejercicios.Zona_muscular
    FROM RutinaxEjercicio 
    JOIN Ejercicios  ON RutinaxEjercicio.Id_ejercicios = Ejercicios.Id_ejercicios
);
GO

-- Pruebas RutinaxEjercicio --
-- Procedures --
EXEC Insertar_Rutina_Ejercicio 501, 1; -- Asociar 'Press de Banca' a la Rutina 501
EXEC Insertar_Rutina_Ejercicio 501, 19; -- Asociar 'Dominadas' a la Rutina 501
EXEC Insertar_Rutina_Ejercicio 502, 3; -- Asociar 'Curl de Bíceps' a la Rutina 502

-- Modificar Relación Rutina - Ejercicio (en este caso solo cambiamos el ejercicio)
SELECT * FROM Consultar_Ejercicio_Rutina(501);
EXEC Modificar_Rutina_Ejercicio 501,19, 4; -- Cambiar el ejercicio en la Rutina 501 a 'Curl de Bíceps'
SELECT * FROM Consultar_Ejercicio_Rutina(501);
-- Eliminar Relación Rutina - Ejercicio
EXEC Eliminar_Rutina_Ejercicio 502, 3; -- Eliminar la relación 'Curl de Bíceps' de la Rutina 502

-- Funciones --
SELECT * FROM Consultar_Ejercicio_Rutina(501);
SELECT * FROM Listar_Ejercicios_Por_Rutinas();

--Mediciones
-- Insertar Mediciones
CREATE OR ALTER PROCEDURE Insertar_Mediciones
(
    @Id_mediciones int,
    @Id_clientes int,
    @Horayfecha datetime,
    @Peso float,
    @Porcentaje_grasa float,
    @Porcentaje_musc float,
    @Edad_metab float,
    @Porcen_grasa_visceral varchar(45),
    @Estatura int
)
AS
BEGIN
    INSERT INTO Mediciones (Id_mediciones, Id_clientes,  Horayfecha, Peso, Porcentaje_grasa, Porcentaje_musc, Edad_metab, Porcen_grasa_visceral, Estatura)
    VALUES (@Id_mediciones, @Id_clientes,  @Horayfecha, @Peso, @Porcentaje_grasa, @Porcentaje_musc, @Edad_metab, @Porcen_grasa_visceral, @Estatura);
END;
GO

-- Modificar Mediciones
CREATE OR ALTER PROCEDURE Modificar_Mediciones
(
    @Id_mediciones int,
    @Id_clientes int,
    @Horayfecha datetime,
    @Peso float,
    @Porcentaje_grasa float,
    @Porcentaje_musc float,
    @Edad_metab float,
    @Porcen_grasa_visceral varchar(45),
    @Estatura int
)
AS
BEGIN
    UPDATE Mediciones
    SET Id_clientes = @Id_clientes,
        Horayfecha = @Horayfecha,
        Peso = @Peso,
        Porcentaje_grasa = @Porcentaje_grasa,
        Porcentaje_musc = @Porcentaje_musc,
        Edad_metab = @Edad_metab,
        Porcen_grasa_visceral = @Porcen_grasa_visceral,
        Estatura = @Estatura
    WHERE Id_mediciones = @Id_mediciones;
END;
GO

-- Eliminar Mediciones
CREATE OR ALTER PROCEDURE Eliminar_Mediciones
(
    @Id_mediciones int
)
AS
BEGIN
    DELETE FROM Mediciones WHERE Id_mediciones = @Id_mediciones;
END;
GO

-- Consultar una Medición
CREATE OR ALTER FUNCTION Consultar_Mediciones
(
    @Id_mediciones int
)
RETURNS TABLE
AS
RETURN
(
    SELECT * FROM Mediciones WHERE Id_mediciones = @Id_mediciones
);
GO

-- Listar Mediciones
CREATE OR ALTER FUNCTION Listar_Mediciones
()
RETURNS TABLE
AS
RETURN
(
    SELECT CLI.Nombre_completo,MED.* FROM Mediciones as MED 
	JOIN Clientes as CLI ON CLI.Id_clientes = MED.Id_clientes

);
GO

-- Ejemplos para Mediciones

-- Insertar una medición
EXEC Insertar_Mediciones 1, 301, '2023-01-01 08:00:00', 70.5, 15.2, 25.5, 30.0, 'Normal', 170;
EXEC Insertar_Mediciones 2, 302, '2023-01-02 09:00:00', 75.0, 18.0, 23.0, 28.0, 'Normal', 175;
EXEC Insertar_Mediciones 4, 304, '2023-01-04 11:00:00', 82.3, 20.2, 21.8, 35.0, 'Normal', 180;
EXEC Insertar_Mediciones 5, 305, '2023-01-05 12:00:00', 65.8, 13.8, 27.0, 29.0, 'Normal', 155;

-- Modificar una medición
EXEC Modificar_Mediciones 1, 301, '2023-02-01 09:30:00', 72.0, 14.5, 26.0, 31.0, 'Normal', 172;
EXEC Modificar_Mediciones 2, 302, '2023-01-02 09:30:00', 76.5, 19.0, 22.5, 27.5, 'Normal', 178;
-- Eliminar una medición
EXEC Eliminar_Mediciones 2;

-- Consultar una medición
SELECT * FROM Consultar_Mediciones(1);

-- Listar todas las mediciones con el nombre del cliente
SELECT * FROM Listar_Mediciones();


--Reporte
 -- Insertar Reporte
-- Insertar Reporte
CREATE OR ALTER PROCEDURE Insertar_Reporte
(
    @Id_reporte int,
    @Id_mediciones int
)
AS
BEGIN
    DECLARE @IMC float,
            @Cantidad_proteina varchar(200),
            @Cantidad_agua float,
            @Clasificacion_IMC varchar(45);

    -- Obtener datos necesarios de la medicion
    SELECT 
        @IMC = Peso / POWER((Estatura / 100), 2),
        @Cantidad_proteina = Case when  Sexo = 'Masculino' 
		                      then 'Lo minimo de proteinas que debes de consumir es: ' + CAST(ROUND(1.7 * Peso, 2) AS varchar(50)) 
							  + ' Lo maximo de proteinas que debes de consumir es: ' + CAST(ROUND(2.5 * Peso, 2) AS varchar(50))
							  Else
							  'Lo minimo de proteinas que debes de consumir es: ' + CAST(ROUND(1.6 * Peso, 2) AS varchar(50))
							  + ' Lo maximo de proteinas que debes de consumir es: ' + CAST(ROUND(1.8 * Peso, 2) AS varchar(50))
							  End,
        @Cantidad_agua =  ROUND((Peso/7) * 250 , 0),
        @Clasificacion_IMC = 
            CASE
                WHEN @IMC < 16 THEN 'Delgadez Severa'
                WHEN @IMC >= 16 AND @IMC <= 16.99 THEN 'Delgadez Moderada'
				WHEN @IMC >= 17 AND @IMC <= 18.49 THEN 'Delgadez Leve'
				WHEN @IMC >= 18.5 AND @IMC <= 24.9 THEN 'Normal'
                WHEN @IMC >= 25 AND @IMC <= 29.9 THEN 'Preobeso'
				WHEN @IMC >= 30 AND @IMC <= 34.9 THEN 'Obesidad Leve'
				WHEN @IMC >= 35 AND @IMC <= 39.9 THEN 'Obesidad Media'
                WHEN @IMC >= 40 THEN 'Obesidad Mórbida'
                ELSE 'No clasificado'
            END
    FROM Mediciones
	JOIN Clientes as CLI ON CLI.Id_clientes = Mediciones.Id_clientes
    WHERE Id_mediciones = @Id_mediciones;

    -- Insertar en la tabla Reporte
    INSERT INTO Reporte (Id_reporte, Id_mediciones, IMC, Cantidad_proteina, Cantidad_agua , Clasificacion_IMC)
    VALUES (@Id_reporte, @Id_mediciones, @IMC, @Cantidad_proteina, @Cantidad_agua, @Clasificacion_IMC);
END;
GO

-- Modificar Reporte
CREATE OR ALTER PROCEDURE Modificar_Reporte
(
    @Id_reporte int,
    @Id_mediciones int
    -- Puedes agregar más parámetros según lo que desees modificar
)
AS
BEGIN
    DECLARE @IMC float,
            @Cantidad_proteina varchar(200),
            @Cantidad_agua float,
            @Clasificacion_IMC varchar(45);

    -- Obtener datos necesarios de la medicion
    SELECT 
        @IMC = Peso / POWER((Estatura / 100), 2),
        @Cantidad_proteina = Case when  Sexo = 'Masculino' 
		                      then 'Lo minimo de proteinas que debes de consumir es: ' + CAST(ROUND(1.7 * Peso, 2) AS varchar(50)) 
							  + ' Lo maximo de proteinas que debes de consumir es: ' + CAST(ROUND(2.5 * Peso, 2) AS varchar(50))
							  Else
							  'Lo minimo de proteinas que debes de consumir es: ' + CAST(ROUND(1.6 * Peso, 2) AS varchar(50))
							  + ' Lo maximo de proteinas que debes de consumir es: ' + CAST(ROUND(1.8 * Peso, 2) AS varchar(50))
							  End,
        @Cantidad_agua =  ROUND((Peso/7) * 250 , 0),
        @Clasificacion_IMC = 
            CASE
                WHEN @IMC < 16 THEN 'Delgadez Severa'
                WHEN @IMC >= 16 AND @IMC <= 16.99 THEN 'Delgadez Moderada'
				WHEN @IMC >= 17 AND @IMC <= 18.49 THEN 'Delgadez Leve'
				WHEN @IMC >= 18.5 AND @IMC <= 24.9 THEN 'Normal'
                WHEN @IMC >= 25 AND @IMC <= 29.9 THEN 'Preobeso'
				WHEN @IMC >= 30 AND @IMC <= 34.9 THEN 'Obesidad Leve'
				WHEN @IMC >= 35 AND @IMC <= 39.9 THEN 'Obesidad Media'
                WHEN @IMC >= 40 THEN 'Obesidad Mórbida'
                ELSE 'No clasificado'
            END
    FROM Mediciones
	JOIN Clientes as CLI ON CLI.Id_clientes = Mediciones.Id_clientes
    WHERE Id_mediciones = @Id_mediciones;

    -- Modificar en la tabla Reporte
    UPDATE Reporte
    SET 
	    Id_mediciones = @Id_mediciones,
        IMC = @IMC,
        Cantidad_proteina = @Cantidad_proteina,
        Cantidad_agua = @Cantidad_agua,
        Clasificacion_IMC = @Clasificacion_IMC
    WHERE Id_reporte = @Id_reporte;
END;
GO


-- Eliminar Reporte
CREATE OR ALTER PROCEDURE Eliminar_Reporte
(
    @Id_reporte int
)
AS
BEGIN
    DELETE FROM Reporte WHERE Id_reporte = @Id_reporte;
END;
GO

-- Consultar un Reporte
CREATE OR ALTER FUNCTION Consultar_Reporte
(
    @Id_reporte int
)
RETURNS TABLE
AS
RETURN
(
    SELECT  Id_reporte, Id_mediciones, IMC, Cantidad_proteina, Cantidad_agua as Cantidad_agua_mL , Clasificacion_IMC
	FROM Reporte WHERE Id_reporte = @Id_reporte
);
GO

-- Listar Reportes
CREATE OR ALTER FUNCTION Listar_Reportes
()
RETURNS TABLE
AS
RETURN
(
    SELECT Id_reporte, Id_mediciones, IMC, Cantidad_proteina, Cantidad_agua as Cantidad_agua_mL , Clasificacion_IMC
	FROM Reporte
);
GO

-- Insertar Reporte para Mediciones con Id_mediciones = 1
EXEC Insertar_Reporte 1, 1;

-- Modificar Reporte para Mediciones con Id_mediciones = 4
EXEC Modificar_Reporte 1, 4;

-- Modificar Reporte para Mediciones con Id_mediciones = 5
EXEC Modificar_Reporte 5, 3;

-- Eliminar Reporte para Mediciones con Id_mediciones = 1
EXEC Eliminar_Reporte 1;

-- Consultar Reporte para Mediciones con Id_mediciones = 4
SELECT * FROM Consultar_Reporte(1);

-- Listar todos los Reportes
SELECT * FROM Listar_Reportes();