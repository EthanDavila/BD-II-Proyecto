Create Database Farmacia

restore database Farmacia
from disk = 'C:\Proyecto-BaseDatos\FarmaciaBackUp.bak'
with replace

BackUp Database Farmacia	
to disk = 'C:\Proyecto-BaseDatos\FarmaciaBackUp.bak'
go

Use Farmacia

Create Login adminFarmacia with Password = 'adminFarmacia'
go

Grant Execute on Validar_Acceso to adminFarmacia
Grant Execute on [Insertar Producto] to adminFarmacia
Grant Execute on [Venta de Medicamento] to adminFarmacia
Grant Execute on [Insertar Cliente] to adminFarmacia
Grant Execute on [Insertar Empleado] to adminFarmacia
Grant Execute on [Insertar Compras] to adminFarmacia
Grant Execute on [Buscar Medicamento] to adminFarmacia
Grant Execute on [Buscar Cliente] to adminFarmacia
Grant Execute on [Buscar Empleado] to adminFarmacia
Grant Execute on [Listar Clientes] to adminFarmacia
Grant Execute on [Listar Compras] to adminFarmacia
Grant Execute on [Listar Empleados] to adminFarmacia
Grant Execute on [Listar Productos] to adminFarmacia
Grant Execute on [Listar Proveedores] to adminFarmacia
Grant Execute on [Mostrar Medicamentos] to adminFarmacia
Grant Execute on [Mostrar Inventario del Producto] to adminFarmacia
Grant Execute on [EstadoProducto] to adminFarmacia
Grant Select on Producto to adminFarmacia
Grant Select on Ordenes to adminFarmacia
Grant Select on Usuario to adminFarmacia
Grant Select on Compras to adminFarmacia
Grant Select on Cliente to adminFarmacia
Grant Select on Empleado to adminFarmacia
Grant Select on Proveedor to adminFarmacia
Grant Select on [Detalles de Ordenes] to adminFarmacia
Grant Select on [Detalle de Compra] to adminFarmacia

Delete from Usuario


Use Farmacia

sp_adduser adminFarmacia, adminFarmacia

Create table Usuario 
(idUsuario int primary key identity(1,1),
 Usuario varchar(50),
 contrase�a varchar(50),
 rol varchar(50),
 estado varchar(50))

Alter table Usuario
Add [ID Colaborador] int

Select * from Usuario

Drop Table Usuario

Update Usuario Set [ID Colaborador] = 1
Where idUsuario = 1
Update Usuario Set [ID Colaborador] = 2
Where idUsuario = 2

Create Table Colaborador([ID Colaborador] int primary key identity(1,1), Nombre Nvarchar(80), Apellidos Nvarchar(80))

Drop Table Colaborador

Insert into Colaborador values ('Ethan', 'D�vila')
Insert into Colaborador values ('Axel', 'Moreno')

Select * from Colaborador

Alter procedure [dbo].[Insertar_Usuario]
 @usuario varchar(50), @contrase�a varchar(50), @rol varchar(50)
 as
 insert into Usuario(usuario, contrase�a, rol, Estado) values
 (@usuario, ENCRYPTBYPASSPHRASE( @contrase�a,  @contrase�a), @rol, 'Habilitado')

 Execute dbo.Insertar_Usuario 'Ethan', 'admin', 'Administrador'
 Execute dbo.Insertar_Usuario 'Axel', 'emp', 'Empleado'

 Drop Table Usuario

Alter procedure [dbo].[Validar_Acceso]
@usuario varchar(50),
@contrase�a varchar(50)
as
if exists (Select usuario from Usuario
            where  cast (DECRYPTBYPASSPHRASE(@contrase�a, contrase�a) as Varchar(100)) = @contrase�a
			 and usuario = @Usuario and Estado = 'Habilitado' )
			 select 'Acceso Exitoso' as Resultado, C.Nombre + ' ' + C.Apellidos as Usuario, rol
			 from Usuario as U Inner Join Colaborador as C on C.[ID Colaborador] = U.[ID Colaborador]
			 where  cast (DECRYPTBYPASSPHRASE(@contrase�a, contrase�a) as Varchar(100)) = @contrase�a
			 and U.usuario = @Usuario and U.Estado = 'Habilitado'
			 else
			 Select 'Acceso Denegado' as Resultado


Execute dbo.Validar_Acceso 'Ethan', 'admin'

Drop Procedure Validar_Acceso

Create Table Producto
([ID Producto] int primary key identity(1,1) not null,
"Nombre" Nvarchar(80) not null,
Stock int not null,
Precio money not null,
[ID Proveedor] int not null,
"Pa�s" Nvarchar(20) not null,
"Clasificaci�n" Nvarchar(30) not null,
"Descripci�n" Nvarchar(MAX) not null)

Alter Table Producto
add "Estado" Nvarchar(40)

Select * from Producto

Update Producto Set Estado = 'Habilitado'
Where [ID Producto] between 1 and 4

Create Table Proveedor
([ID Proveedor] int primary key identity(1,1) not null,
"Nombre de la Compa��a" Nvarchar(40) not null,
"Nombre del Contacto" Nvarchar(40) not null,
"Ciudad" Nvarchar(40) not null,
"Direcci�n" Nvarchar(500) not null,
[No. Telef�nico] Nvarchar(10) not null)

Create Table Compras(
[ID Compra] int primary key identity(1,1),
[ID Producto] int not null,
Cantidad int not null,
[Fecha de Compra] Datetime not null)

Create Table [Detalle de Compra](
[ID Detalle de Compra] int primary key identity(1,1) not null,
[ID Compra] int, 
[ID Producto] int not null,
[ID Proveedor] int not null,
[Fecha de Compra] Datetime not null,
Cantidad int not null)

Create Table Cliente
([ID Cliente] int primary key identity(1,1) not null,
"Nombre" Nvarchar(40) not null,
"Apellidos" Nvarchar(60),
"Direcci�n" Nvarchar(500) not null,
"C�dula" Nvarchar(16) not null,
"G�nero" char(1) not null,
"Tel�fono" Nvarchar(10))

Create Table Empleado
([ID Empleado] int primary key identity(1,1) not null,
"Nombre" Nvarchar(40) not null,
"Apellidos" Nvarchar(40),
"Direcci�n" Nvarchar(500) not null,
[Fecha de Nacimiento] Datetime not null,
[Fecha de Contrataci�n] Datetime not null,
"Departamento" Nvarchar(40),
[No. Telef�nico] Nvarchar(10) not null,
"Descripci�n" Nvarchar(200) not null)

Alter Table Empleado
Add Estado Nvarchar(40)

Update Empleado Set Estado = 'Habilitado'
Where [ID Empleado] between 1 and 3

Create Table Ordenes
([ID Orden] int primary key identity(1,1) not null,
[ID Cliente] int not null,
[ID Empleado] int not null,
[ID Producto] int,
Cantidad int,
[Fecha de la Orden] Datetime not null)

Create Table [Detalles de Ordenes]
([ID Detalle de Orden] int primary key identity(1,1) not null,
[ID Orden] int not null,
[ID Producto] int not null,
Cantidad int not null)

/*Llaves Foraneas*/
Alter Table Producto
Add foreign key([ID Proveedor])
References Proveedor([ID Proveedor])

Alter Table Compras
Add foreign key([ID Producto])
References Producto([ID Producto])

Alter Table Ordenes
Add foreign key([ID Cliente])
References Cliente([ID Cliente])

Alter Table Ordenes
Add foreign key([ID Empleado])
References Empleado([ID Empleado])

Alter Table [Detalles de Ordenes]
Add foreign key([ID Orden])
References Ordenes([ID Orden])

Alter Table [Detalles de Ordenes]
Add foreign key([ID Producto])
References Producto([ID Producto])

/*Procesos Almacenados*/

Alter Procedure [dbo].[Listar Clientes]
as
	Select * from Cliente Order By [ID Cliente] asc

Alter Procedure [dbo].[Listar Productos]
as
	Select * from Producto 
	Where Estado Like 'Habilitado'
	Order By [ID Producto] asc

Alter Procedure [dbo].[Listar Empleados]
as
	Select * from Empleado
	Where Estado Like 'Habilitado'
	Order By [ID Empleado] asc

Alter Procedure [dbo].[Listar Proveedores]
as
	Select * from Proveedor Order By [ID Proveedor] asc

Alter Procedure [dbo].[Listar Compras]
as
	Select * from Compras Order By [ID Compra] asc

Alter Procedure [dbo].[Mostrar Medicamentos]
as
	Select [ID Producto], Nombre, Stock, Precio, Descripci�n, Estado from Producto

Alter Procedure [dbo].[Mostrar Inventario del Producto] @Medicamento Nvarchar(40)
as	
	Select Nombre as [Nombre del Medicamento], Stock as [Cantidad Disponible] from Producto
	Where Nombre Like @Medicamento

Alter Procedure [dbo].[Insertar Compras] @ID_Producto int, @Cantidad int, @Medicamento Nvarchar(40)
as
	Insert into Compras([ID Producto], Cantidad, [Fecha de Compra])
	values(@ID_Producto, @Cantidad, GETDATE())
	Update Producto Set Stock = Stock + @Cantidad
	Where Nombre Like @Medicamento

Drop Procedure [Insertar Compras]

Alter Procedure [dbo].[Insertar Producto] @Nombre Nvarchar(40), 
@Stock int,
@Precio money,
@ID_Proveedor int,
@Pa�s Nvarchar(20),
@Clasificaci�n Nvarchar(30),
@Descripci�n Nvarchar(MAX)
AS
	Insert into Producto(Nombre, Stock, Precio, [ID Proveedor], Pa�s, Clasificaci�n, Descripci�n, Estado)
	values (@Nombre, @Stock, @Precio, @ID_Proveedor, @Pa�s, @Clasificaci�n, @Descripci�n, 'Habilitado')

Alter Procedure [dbo].[Insertar Empleado] @Nombre Nvarchar(40),
@Apellidos Nvarchar(40),
@Direcci�n Nvarchar(500),
@Fecha_Nacimiento Datetime,
@Fecha_Contrataci�n Datetime,
@Departamento Nvarchar(40),
@No_Telef�nico Nvarchar(10),
@Descripci�n Nvarchar(200)
AS
	Insert into Empleado(Nombre, Apellidos, Direcci�n, [Fecha de Nacimiento], [Fecha de Contrataci�n], Departamento, [No. Telef�nico], Descripci�n, Estado)
	values(@Nombre, @Apellidos, @Direcci�n, @Fecha_Nacimiento, @Fecha_Contrataci�n, @Departamento, @No_Telef�nico, @Descripci�n, 'Habilitado')
	Insert into Colaborador(Nombre, Apellidos) values (@Nombre, @Apellidos)
	insert into Usuario(usuario, contrase�a, rol, Estado, [ID Colaborador]) values
	(@Nombre, ENCRYPTBYPASSPHRASE( 'emp',  'emp'), 'Empleado', 'Habilitado', @@IDENTITY)

Select * from Empleado
Drop Table Empleado
Drop Procedure [Insertar Empleado]

Alter Procedure [dbo].[Venta de Medicamento] @ID_Cliente int, @ID_Empleado int, @ID_Producto int, @Cantidad int, @Medicamento Nvarchar(40)
AS
	Insert into Ordenes([ID Cliente], [ID Empleado], [Fecha de la Orden], [ID Producto], Cantidad)
	values (@ID_Cliente, @ID_Empleado, GETDATE(), @ID_Producto, @Cantidad)
	Update Producto Set Stock = Stock - @Cantidad
	Where Nombre Like @Medicamento

Drop Procedure [Venta de Medicamento]

Alter Procedure [dbo].[Insertar Cliente] @Nombre Nvarchar(40), 
@Apellidos Nvarchar(60),
@Direcci�n Nvarchar(MAX),
@C�dula Nvarchar(16),
@G�nero char(1),
@Tel�fono Nvarchar(10)
AS
	Insert into Cliente(Nombre, Apellidos, Direcci�n, C�dula, G�nero, Tel�fono)
	values(@Nombre, @Apellidos, @Direcci�n, @C�dula, @G�nero, @Tel�fono)

Alter Procedure [dbo].[Insertar Proveedor] @NombreCompa��a Nvarchar(80),
@NombreContacto Nvarchar(40),
@Ciudad Nvarchar(40),
@Direcci�n Nvarchar(Max),
@NoTel�fono Nvarchar(14)
as
	Insert into Proveedor([Nombre de la Compa��a], [Nombre del Contacto], Ciudad, Direcci�n, [No. Telef�nico])
	values(@NombreCompa��a, @NombreContacto, @Ciudad, @Direcci�n, @NoTel�fono)

Drop Procedure [Insertar Cliente]

Alter Procedure [dbo].[Buscar Medicamento] @dato Nvarchar(40)
as
	Select P.[ID Producto], P.Nombre as Medicamento, Stock as Inventario, Pr.[Nombre del Contacto] as Proveedor, Precio as [Precio Unitario], P.Clasificaci�n, P.Descripci�n, P.Estado
	from Producto as P Inner Join Proveedor as Pr on P.[ID Proveedor] = Pr.[ID Proveedor]
	Where P.Nombre Like @dato + '%'
	or P.Pa�s Like @dato+ '%'
	or P.Clasificaci�n Like @dato + '%'
	or P.Descripci�n Like @dato +'%'
	or P.Estado Like @dato + '%'
	or Pr.[Nombre del Contacto] Like @dato + '%'

Alter Procedure [dbo].[Buscar Cliente] @dato Nvarchar(40)
as
	Select Nombre, Apellidos, Direcci�n, G�nero, C�dula, Tel�fono from Cliente
	Where Nombre Like @dato + '%'
	or Apellidos Like @dato+ '%'
	or Direcci�n Like @dato + '%'
	or G�nero Like @dato +'%'
	or C�dula Like @dato + '%'
	or Tel�fono Like @dato + '%'

Alter Procedure [dbo].[Buscar Empleado] @dato Nvarchar(40)
as
	Select Nombre, Apellidos, Direcci�n, Departamento, [No. Telef�nico],Descripci�n from Empleado
	Where Nombre Like @dato + '%'
	or Apellidos Like @dato+ '%'
	or Direcci�n Like @dato + '%'
	or Departamento Like @dato +'%'
	or [No. Telef�nico] Like @dato + '%'
	or Descripci�n Like @dato + '%'

Alter Procedure [dbo].[Buscar Proveedor] @dato Nvarchar(40)
as
	Select [Nombre de la Compa��a], [Nombre del Contacto],Ciudad, Direcci�n, [No. Telef�nico] from Proveedor
	Where [Nombre de la Compa��a] Like @dato + '%'
	or [Nombre del Contacto] Like @dato + '%'
	or Ciudad Like @dato + '%'
	or Direcci�n Like @dato + '%'
	or [No. Telef�nico] Like @dato + '%'
	
Alter Procedure [dbo].[EstadoProducto] @ID_Medicamento int
as 
	Declare @Estado varchar(60)
	Set @Estado = (Select Estado from Producto where [ID Producto] = @ID_Medicamento)
	if(@Estado = 'Habilitado')
	update Producto set Estado = 'Deshabilitado' where [ID Producto] = @ID_Medicamento
	else
	update Producto set Estado = 'Habilitado' where [ID Producto] = @ID_Medicamento

/*Inserci�n de Datos en Tabla Proveedores*/
Insert into Proveedor([Nombre de la Compa��a], [Nombre del Contacto], Ciudad, Direcci�n, [No. Telef�nico]) values ('Laboratorios Ceguel, S. A.', 'Miguel Ni�o', 'Managua', 'Pista Juan Pablo II Edificio C�sar Guerrero Apdo. Postal P-188 Managua,, Nicaragua, Managua 13013', '7516-5659')
Insert into Proveedor([Nombre de la Compa��a], [Nombre del Contacto], Ciudad, Direcci�n, [No. Telef�nico]) values ('Droguer�a Saimed de Honduras S. A.', 'Luis Balladares', 'Managua', '1ERA ENTRADA MANO IZQUIERA BLVDA LA UT ANILLO PERIFERICO SUR TEGUCIGALPA HN', '7769-0197')
Insert into Proveedor([Nombre de la Compa��a], [Nombre del Contacto], Ciudad, Direcci�n, [No. Telef�nico]) values ('Laboratorios SOLKA S.A.', 'Alexander Espinoza', 'Managua', 'Km 16 � Carretera A Masaya - Managua', '8460-5330')
Select * from Proveedor

/*Inserci�n de Datos en Tabla Producto*/
Insert into Producto (Nombre, Stock, Precio, [ID Proveedor], Pa�s, Clasificaci�n, Descripci�n) values ('Difenhidramina', 200, 28, 1, 'Nicaragua', 'Oral', 'Jarabe; Cada 5 mL contiene 12.5 mg; Se administra de manera oral; Antihistam�aco indicado para el alivio sintom�tico de las condiciones al�rgicas tales como: rinitis, urticaria, prurito, conjuntivitis, angioedema; Mantengase fuera del alcance de los ni�os')
Insert into Producto (Nombre, Stock, Precio, [ID Proveedor], Pa�s, Clasificaci�n, Descripci�n) values ('Azitromicina', 100, 83, 2, 'Honduras', 'Oral', 'Pastillas; 500 mg tabletas recubiertas; Se administra de manera oral; Se consume seg�n indicaiones m�dicas')
Select * from Producto

/*Inserci�n de Datos en Tabla Empleado*/
Insert into Empleado (Nombre, Apellidos, Direcci�n, [Fecha de Nacimiento], [Fecha de Contrataci�n], Departamento, [No. Telef�nico], Descripci�n)
values ('Ethan Jahir', 'D�vila Larios', 'Jardines de Veracruz - Casa J-13', '2004-08-06', '2021-11-01', 'Managua', '78866-5375', 'Estudiante Universitario')
Select * from Empleado

Alter Procedure [dbo].[Mostrar Compras]
as
	Select C.[ID Compra] as ID_Compra, P.Nombre as Medicamento, C.Cantidad, C.[Fecha de Compra] as Fecha_Compra from Compras as C Inner Join Producto as P on C.[ID Producto] = P.[ID Producto]

Exec [Mostrar Compras]

ALTER Procedure [dbo].[Mostrar Medicamentos]
as
	Select P.[ID Producto] as ID_Producto, P.Nombre as Medicamento, Stock as Inventario, Pr.[Nombre del Contacto] as Proveedor, P.Precio, P.Pa�s, P.Clasificaci�n, P.Descripci�n, P.Estado
	from Producto as P Inner Join Proveedor as Pr on P.[ID Proveedor] = Pr.[ID Proveedor]

Exec [Mostrar Medicamentos]

ALTER Procedure [dbo].[Mostrar Ventas]
as
	Select P.Nombre as Medicamento, E.Nombre as Empleado, C.Nombre as Cliente, O.Cantidad as Cantidad_Comprada, O.[Fecha de la Orden] as Fecha_Orden from Ordenes as O
	Inner Join Producto as P on O.[ID Producto] = P.[ID Producto]
	Inner Join Empleado as E on O.[ID Empleado] = E.[ID Empleado]
	Inner Join Cliente as C on O.[ID Cliente] = C.[ID Cliente]

Exec [Mostrar Ventas]

Create Procedure [dbo].[Buscar Compra] @dato Nvarchar(40)
as
	Select C.[ID Compra] as ID_Compra, P.Nombre as Medicamento, C.Cantidad, C.[Fecha de Compra] as Fecha_Compra from Compras as C Inner Join Producto as P on C.[ID Producto] = P.[ID Producto]
	Where P.Nombre Like @dato + '%'

Create Procedure [dbo].[Buscar Venta] @dato Nvarchar(40)
as
	Select P.Nombre as Medicamento, E.Nombre as Empleado, C.Nombre as Cliente, O.Cantidad as [Cantidad Comprada], O.[Fecha de la Orden] from Ordenes as O
	Inner Join Producto as P on O.[ID Producto] = P.[ID Producto]
	Inner Join Empleado as E on O.[ID Empleado] = E.[ID Empleado]
	Inner Join Cliente as C on O.[ID Cliente] = C.[ID Cliente]
	Where P.Nombre Like @dato + '%'
	or E.Nombre Like @dato + '%'
	or C.Nombre Like @dato + '%'

Alter Procedure [dbo].[Mostrar Empleados]
as
	Select Nombre, Apellidos, Direcci�n, [Fecha de Nacimiento] as Fecha_Nacimiento, [Fecha de Contrataci�n] as Fecha_Contrataci�n, 
	Departamento, [No. Telef�nico] as Tel�fono, Descripci�n, Estado from Empleado

Create Procedure [dbo].[Mostrar Proveedores]
as
	Select [Nombre de la Compa��a] as Nombre_Compa��a, [Nombre del Contacto] as Contacto, Ciudad, Direcci�n, [No. Telef�nico] as Tel�fono from Proveedor

Create Procedure [dbo].[Mostrar Clientes]
as
	Select Nombre, Apellidos, Direcci�n, C�dula, G�nero, Tel�fono from Cliente

Create procedure [dbo].[Editar Producto] @ID_Producto int, @Nombre Nvarchar(15), @Stock int, @Precio money, @ID_Proveedor int, @Pa�s Nvarchar(90),
@Clasificaci�n Nvarchar(40), @Descripci�n Nvarchar(MAX)
as
	 update Producto set Nombre =  @Nombre, Stock = @Stock, Precio = @Precio, [ID Proveedor] = @ID_Proveedor, Pa�s = @Pa�s,
	 Clasificaci�n = @Clasificaci�n, Descripci�n = @Descripci�n
	 where [ID Producto] = @ID_Producto


Create procedure [dbo].[Editar Proveedor] @ID_Proveedor int, @NombreCompa��a Nvarchar(50), @NombreContacto Nvarchar(50), @Ciudad Nvarchar(40),
@Direcci�n Nvarchar(MAX), @NoTel�fono Nvarchar(MAX)
as
	 update Proveedor set [Nombre de la Compa��a] =  @NombreCompa��a, [Nombre del Contacto] = @NombreContacto, Ciudad = @Ciudad,
	 Direcci�n = @Direcci�n, [No. Telef�nico] = @NoTel�fono
	 where [ID Proveedor] = @ID_Proveedor

Create procedure [dbo].[Editar Cliente] @ID_Cliente int, @Nombre Nvarchar(50), @Apellidos Nvarchar(50), @Direcci�n Nvarchar(MAX), @C�dula Nvarchar(16),
@G�nero Nvarchar(1), @Tel�fono Nvarchar(MAX)
as
	 update Cliente set Nombre =  @Nombre, Apellidos = @Apellidos, Direcci�n = @Direcci�n, C�dula = @C�dula, G�nero = @G�nero, Tel�fono = @Tel�fono
	 where [ID Cliente] = @ID_Cliente

Create procedure [dbo].[Editar Empleado] @ID_Empleado int, @Nombre Nvarchar(50), @Apellidos Nvarchar(50), @Direcci�n Nvarchar(MAX),
@Fecha_Nacimiento Datetime, @Fecha_Contrataci�n Datetime, @Departamento Nvarchar(40), @No_Telef�nico Nvarchar(10), @Descripci�n Nvarchar(200)
as
	 update Empleado set Nombre =  @Nombre, Apellidos = @Apellidos, Direcci�n = @Direcci�n, [Fecha de Contrataci�n] = @Fecha_Contrataci�n,
	 [Fecha de Nacimiento] = @Fecha_Nacimiento, Departamento = @Departamento, [No. Telef�nico] = @No_Telef�nico, Descripci�n = @Descripci�n
	 where [ID Empleado] = @ID_Empleado
	 update Colaborador set Nombre = @Nombre, Apellidos = @Apellidos
	 Where [ID Colaborador] = @ID_Empleado
	 update Usuario set usuario = @Nombre
	 Where idUsuario = @ID_Empleado

Create Procedure [dbo].[Estado Empleado] @ID_Empleado int
as 
	Declare @Estado varchar(60)
	Set @Estado = (Select Estado from Empleado where [ID Empleado] = @ID_Empleado)
	if(@Estado = 'Habilitado')
	update Empleado set Estado = 'Deshabilitado' where [ID Empleado] = @ID_Empleado
	else
	update Empleado set Estado = 'Habilitado' where [ID Empleado] = @ID_Empleado
	if(@Estado = 'Habilitado')
	update Usuario set Estado = 'Deshabilitado' where idUsuario = @ID_Empleado
	else
	update Usuario set Estado = 'Habilitado' where idUsuario = @ID_Empleado

Update Empleado Set Estado = 'Habilitado'
Where [ID Empleado] = 1

Update Usuario Set Estado = 'Habilitado'
Where idUsuario = 1