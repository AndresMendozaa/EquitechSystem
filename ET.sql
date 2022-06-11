create database Proyecto;
use Proyecto;

create table Cliente(
ID_cliente int auto_increment not null,
Nombre_cliente varchar(100) not null,
Apellidos_cliente varchar(100) not null,
Direccion_Cliente varchar (100) not null,
Telefono varchar(10) not null,
Correo varchar(100) not null,
primary key (ID_cliente)
);

create table Servicio(
ID_servicio int auto_increment not null,
Nombre_servicio varchar(100) not null,
T_servicio varchar(100) not null,
Costo_servicio int not null,
primary key (ID_servicio)
);

create table Productos(
ID_producto int auto_increment not null,
Nombre_producto varchar (100) not null,
Costo_producto int not null,
Categoria varchar(100) not null,
primary key (ID_producto)
);

create table Proveedores(
ID_proveedor int auto_increment not null,
Nombre_proveedor varchar (100) not null,
Apellidos_proveedor varchar (100) not null,
Empresa_proveedor varchar(100) not null,
Direccion_proveedor varchar(100) not null,
Correo_proveedor varchar(100) not null,
Telefono_proveedor varchar(100) not null,
primary key (ID_proveedor)
);

create table Empleados(
ID_empleado int auto_increment not null,
Nombre_empleado varchar(100) not null,
Apellido_empleado varchar(100) not null,
Puesto varchar(100) not null,
Salario_empleados int not null,
Direccion_empleado varchar(100) not null,
Telefono_empleado varchar(100) not null,
Correo_empleado varchar(100) not null,
primary key (ID_empleado)
);

create table ClienteServicio(
ID_CS int auto_increment not null,
ID_clienteCS int not null, -- SE HACE UNA BUSQUEDA MEDIANTE EL IDCLIENTE
Nombre_Cliente varchar(100),
ID_ServicioCS int not null,
Nombre_Servicio varchar(100),
FechaCS date not null,
Descripcion varchar(100),
primary key (ID_CS),
foreign key (ID_clienteCS) references Cliente(ID_Cliente) on delete cascade,
foreign key (ID_ServicioCS) references Servicio(ID_servicio) on delete cascade
);



create table ProductosProveedores(
ID_PP int auto_increment not null,
ID_ProveedorPP int not null,
Nombre_ProveedorPP varchar(100),
ID_ProductoPP  int not null,
Nombre_ProductoPP varchar(100),-- SE HACE UNA BUSQUEDA MEDIANTE EL ID PROVEEDOR
FechaPP date not null,
primary key(ID_PP),
foreign key (ID_ProductoPP) references Productos(ID_producto) on delete cascade,
foreign key (ID_ProveedorPP) references Proveedores(ID_proveedor) on delete cascade
);


-- 1 ALTA CLIENTE
    delimiter //
    create procedure Alta_Cliente(Nombre_clienteAlta varchar(100), Apellidos_clienteAlta varchar(100), Direccion_ClienteAlta varchar (100), TelefonoAlta varchar (10), CorreoAlta varchar(100))
    begin
    if(not exists(select Telefono from Cliente where Telefono like TelefonoAlta))then
    insert into Cliente (Nombre_cliente, Apellidos_cliente, Direccion_Cliente, Telefono, Correo) values (Nombre_clienteAlta, Apellidos_clienteAlta, Direccion_ClienteAlta, TelefonoAlta, CorreoAlta);
    end if;
    end//
    delimiter ;
    
 call Alta_Cliente('alondra', 'Obesa', 'Btijerina 980 8 de noviembre', 8333902544, 'LH@gmail.com');
select @msg;
select * from cliente;

-- 2 CAMBIOS CLIENTE
    delimiter //
    create procedure Cambios_Cliente(ID_ClienteCambios int, Nombre_clienteCambios varchar(100), Apellidos_clienteCambios varchar(100), Direccion_ClienteAlta varchar (100), TelefonoCambios varchar(100), CorreoCambios varchar(100))
    begin
    if(exists(select ID_Cliente from Cliente where ID_Cliente like ID_ClienteCambios))then
    update Cliente set Nombre_cliente = Nombre_clienteCambios, Apellidos_cliente = Apellidos_clienteCambios, Direccion_Cliente = Direccion_ClienteAlta, Telefono = TelefonoCambios, Correo = CorreoCambios where ID_Cliente = ID_ClienteCambios; 
    end if;
    end//
    delimiter ;
    call Cambios_Cliente(1, 'jorge', 'delgado', 'Huisache 39 Arboledas',8334445566, 'cesaraz');
    select @msg1;
    
-- 3 BAJA CLIENTE
    delimiter //
    create procedure Baja_Cliente(ID_ClienteBaja int)
    begin
    if(exists(select ID_Cliente from Cliente where ID_Cliente like ID_ClienteBaja))then
	delete from Cliente where ID_Cliente = ID_ClienteBaja;
    end if;
    end//
    delimiter ;
    call Baja_Cliente(1, @msg2);
    select @msg2;
    

    
    -- 5 ALTA SERVICIO
	delimiter //
    create procedure Alta_Servicio(Nombre_servicioAlta varchar(100), T_servicioAlta varchar(100), Costo_servicioAlta int)
    begin
    if(not exists(select Nombre_servicio from Servicio where Nombre_servicio like Nombre_servicioAlta))then
    insert into servicio (Nombre_servicio, T_servicio, Costo_servicio) values (Nombre_servicioAlta, T_servicioAlta, Costo_servicioAlta);
    end if;
    end//
    delimiter ;
    
call Alta_Servicio('Mantenimiento preventivo', '2 horas', 500);
select @msg4;
select * from servicio;

	-- 6 CAMBIOS SERVICIO
    delimiter //
    create procedure Cambios_Servicio(ID_servicioCambios int, Nombre_servicioCambios varchar(100), T_servicioCambios varchar(100), Costo_servicioCambios int)
    begin
    if(exists(select ID_servicio from servicio where ID_servicio like ID_servicioCambios))then
    update Servicio set Nombre_servicio = Nombre_servicioCambios, T_servicio = T_servicioCambios, Costo_servicio = Costo_servicioCambios where ID_servicio = ID_servicioCambios; 
    end if;
    end//
    delimiter ;
    
    call Cambios_Servicio(2, 'Mantenimiento preventivo', '2 horas', 1000);
    select @msg5;
    
    -- 7 BAJA SERVICIO
	delimiter //
    create procedure Baja_Servicio(ID_servicioBaja int)
    begin
    if(exists(select ID_servicio from servicio where ID_servicio like ID_servicioBaja))then
	delete from servicio where ID_servicio = ID_servicioBaja;
    end if;
    end//
    delimiter ;
    
    call Baja_Servicio(4);
    select @msg6;
    select * from servicio;

    
    -- 9 ALTA PRODUCTOS
	delimiter //
    create procedure Alta_Productos(Nombre_productoAlta varchar (100), Costo_productoAlta int, CategoriaAlta varchar(100))
    begin
    if(not exists(select Nombre_producto from Productos where Nombre_producto like Nombre_productoAlta))then
    insert into Productos (Nombre_producto, Costo_producto, Categoria) values (Nombre_productoAlta, Costo_productoAlta, CategoriaAlta);
    end if;
    end//
    delimiter ;
    
call Alta_Productos('Teclado razer', 5000, 'electronico');
select @msg8;
select * from Productos;

-- 10 CAMBIOS PRODUCTOS
    delimiter //
    create procedure Cambios_Productos(ID_productosCambios int, Nombre_productoCambios varchar (100), Costo_productoCambios int, CategoriaCambios varchar(100))
    begin
    if(exists(select ID_producto from productos where ID_producto like ID_productosCambios))then
    update productos set Nombre_producto = Nombre_productoCambios, Costo_producto = Costo_productoCambios, Categoria = CategoriaCambios where ID_producto = ID_productosCambios; 
    end if;
    end//
    delimiter ;
    
    call Cambios_Productos(1, 'teclado ryzen', 800, 'electronico', @msg9);
    select @msg9;
    
    -- 11 BAJA PRODUCTOS
            delimiter //
    create procedure Baja_Productos(ID_productoBaja int)
    begin
    if(exists(select ID_producto from productos where ID_producto like ID_productoBaja))then
	delete from productos where ID_producto = ID_productoBaja;
    end if;
    end//
    delimiter ;
    
    call Baja_Productos(1, @msg10);
    select @msg10;
    select * from Productos;


-- 13 ALTA PROVEEDORES
	delimiter //
    create procedure Alta_Proveedores(Nombre_proveedorAlta varchar (100), Apellidos_proveedorAlta varchar (100), Empresa_proveedorAlta varchar(100), Direccion_proveedorAlta varchar(100), Correo_proveedorAlta varchar(100), Telefono_proveedorAlta varchar(10))
    begin
    if(not exists(select Telefono_proveedor from Proveedores where Telefono_proveedor like Telefono_proveedorAlta))then
    insert into Proveedores (Nombre_proveedor, Apellidos_proveedor, Empresa_proveedor, Direccion_proveedor ,Correo_proveedor, Telefono_proveedor) values (Nombre_proveedorAlta, Apellidos_proveedorAlta, Empresa_proveedorAlta, Direccion_proveedorAlta, Correo_proveedorAlta, Telefono_proveedorAlta);
    end if;
    end//
    delimiter ;
    
    call Alta_Proveedores('Juan', 'Lopez', 'lerdo de tejada 124 Emilio Portes Gil','proveedor@gmail.com', 833390524);
    select @msg12;
    select * from Proveedores;
    
-- 14 CAMBIOS PROVEEDORES
    delimiter //
    create procedure Cambios_Proveedores(ID_proveedorCambios int,Nombre_proveedorCambios varchar (100), Apellidos_proveedorCambios varchar (100), Empresa_proveedorCambios varchar(100), Direccion_proveedorCambios varchar(100), Correo_proveedorCambios varchar(100), Telefono_proveedorCambios int)
    begin
    if(exists(select ID_proveedor from proveedores where ID_proveedor like ID_proveedorCambios))then
    update proveedores set Nombre_proveedor = Nombre_proveedorCambios, Nombre_proveedor = Nombre_proveedorCambios, Apellidos_proveedor = Apellidos_proveedorCambios, Empresa_proveedor = Empresa_proveedorCambios, Direccion_proveedor = Direccion_proveedorCambios, Correo_proveedor = Correo_proveedorCambios, Telefono_proveedor = Telefono_proveedorCambios where ID_proveedor = ID_proveedorCambios; 
    end if;
    end//
    delimiter ;
    
    call Cambios_Proveedores(1, 'Juan', 'perez', 'proveedorJuan@gmail.com', 833390524, @msg13);
    select @msg13;
    
    -- 15 BAJA PROVEEDORES
    delimiter //
    create procedure Baja_Proveedores(ID_proveedorBaja int)
    begin
    if(exists(select ID_proveedor from proveedores where ID_proveedor like ID_proveedorBaja))then
	delete from proveedores where ID_proveedor = ID_proveedorBaja;
    end if;
    end//
    delimiter ;
    
    call Baja_Proveedores(1, @msg14);
    select @msg14;
    
    -- 17 ALTA EMPLEADOS
	delimiter //
    create procedure Alta_empleados(Nombre_empleadoAlta varchar(100), Apellido_empleadoAlta varchar(100), Puesto_empleadoAlta varchar(100), SalarioAlta int, Direccion_empleadoAlta varchar(100), Telefono_empleadoAlta varchar(100), Correo_empleadoAlta varchar(100))
    begin
    if(not exists(select Telefono_empleado from Empleados where Telefono_empleado like Telefono_empleadoAlta))then
    insert into Empleados (Nombre_empleado, Apellido_empleado, Puesto, Salario_empleados, Direccion_empleado, Telefono_empleado, Correo_empleado) values (Nombre_empleadoAlta, Apellido_empleadoAlta, Puesto_empleadoAlta, SalarioAlta, Direccion_empleadoAlta, Telefono_empleadoAlta, Correo_empleadoAlta);
    end if;
    end//
    delimiter ;
    
call Alta_empleados('Omar', 'chaparro', 'jefe', 3000, 'romeo santos 987 col.emilio portes gil', 833333333, 'romeo@gmail.com');
select @msg16;
select * from Empleados;

-- 18 CAMBIO EMPLEADOS
    delimiter //
    create procedure Cambios_empleados(ID_empleadoCambios int,Nombre_empleadoCambios varchar(100), Apellido_empleadoCambios varchar(100), Puesto_empleadoCambios varchar(100), SalarioCambios int,  Direccion_empleadoCambios varchar(100), Telefono_empleadoCambios varchar(100), Correo_empleadoCambios varchar(100))
    begin
    if(exists(select ID_empleado from empleados where ID_empleado like ID_empleadoCambios))then
    update empleados set Nombre_empleado = Nombre_empleadoCambios, Apellido_empleado = Apellido_empleadoCambios, Puesto = Puesto_empleadoCambios, Salario_empleados = SalarioCambios, Direccion_empleado = Direccion_empleadoCambios, Telefono_empleado = Telefono_empleadoCambios, Correo_empleado = Correo_empleadoCambios where ID_empleado = ID_empleadoCambios; 
    end if;
    end//
    delimiter ;
    
    call Cambios_empleados(1, 'Omar', 'chaparro', 'jefe', 10000, 'romeo santos 987 col.emilio portes gil', 833333333, 'romeo@gmail.com', @msg17);
    select @msg17;
    
    -- 19 BAJA EMPLEADOS
	delimiter //
    create procedure Baja_empleados(ID_empleadoBaja int)
    begin
    if(exists(select ID_empleado from empleados where ID_empleado like ID_empleadoBaja))then
	delete from empleados where ID_empleado = ID_empleadoBaja;
    end if;
    end//
    delimiter ;
    
    call Baja_empleados(1, @msg18);
    select @msg18;
    select * from ClienteServicio;

-- 20 ALTA CLIENTESERVICIO
 delimiter //
    create procedure Alta_ClienteServicio(ID_clienteCSAlta int, Nombre_ClienteAlta varchar(100), ID_ServicioCSAlta int, Nombre_ServicioAlta varchar(100), DescripcionAlta varchar(100))
    begin
    insert into ClienteServicio (ID_clienteCS, Nombre_Cliente, ID_ServicioCS, Nombre_Servicio, FechaCS, Descripcion) values (ID_clienteCSAlta, Nombre_ClienteAlta, ID_ServicioCSAlta, Nombre_ServicioAlta, curdate(), DescripcionAlta);
    end//
    delimiter ;
call Alta_ClienteServicio(4, " Cesar Andres Ramirez Mendoza", 1, "Mantenimiento preventivo", "Limpiamiento del hardware de la maquina" );

-- 21 CAMBIOS CLIENTE SERVICIO
    delimiter //
    create procedure Cambios_ClienteServicio(ID_CSCambios int, ID_clienteCSCambios int, Nombre_ClienteCambios varchar(100), ID_ServicioCSCambios int, Nombre_ServicioCambios varchar(100), DescripcionCambios varchar(100))
    begin
    update ClienteServicio set ID_clienteCS = ID_clienteCSCambios, Nombre_Cliente = Nombre_ClienteCambios, ID_ServicioCS = ID_ServicioCSCambios, Descripcion = DescripcionCambios where ID_CS = ID_CSCambios;
    end//
    delimiter ;
    call Cambios_ClienteServicio(4, 4, " Cesar Andres ", 1, "Mantenimiento preventivo", "nada" );
    Alta_ClienteServicio
    
-- 22 ALTA PRODUCTOS PROVEEDORES

     delimiter //
    create procedure Alta_ProductosProveedores(ID_ProveedorPPAlta int, Nombre_ProveedorPPAlta varchar(100), ID_ProductoPPAlta int, Nombre_ProductoPPAlta varchar(100))
    begin
    insert into ProductosProveedores (ID_ProveedorPP, Nombre_ProveedorPP, ID_ProductoPP, Nombre_ProductoPP, FechaPP) values (ID_ProveedorPPAlta, Nombre_ProveedorPPAlta, ID_ProductoPPAlta, Nombre_ProductoPPAlta, curdate());
    end//
    delimiter ;
    
    select * from productos;
     select * from Proveedores;
    select * from ProductosProveedores;
	call Alta_ProductosProveedores(3, "Rodolfo Santa Marina", 4, "MOBO Asus");

-- 23 CAMBIOS PRODUCTOS PROVEEDORES

    delimiter //
    create procedure Cambios_ProductosProveedores(ID_PPCambios int, ID_ProveedorPPCambios int, Nombre_ProveedorPPCambios varchar(100), ID_ProductoPPCambios int, Nombre_ProductoPPCambios varchar(100))
    begin
    update ProductosProveedores set ID_ProveedorPP = ID_ProveedorPPCambios, Nombre_ProveedorPP = Nombre_ProveedorPPCambios, ID_ProductoPP = ID_ProductoPPCambios, Nombre_ProductoPP = Nombre_ProductoPPCambios where ID_PP = ID_PPCambios;
    end//
    delimiter ;
    

    