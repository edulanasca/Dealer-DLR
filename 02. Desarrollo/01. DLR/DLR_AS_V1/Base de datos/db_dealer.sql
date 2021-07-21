-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 18-06-2021 a las 22:15:57
-- Versión del servidor: 10.3.16-MariaDB
-- Versión de PHP: 7.3.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `id16797125_db_dealer`
--

DELIMITER $$
--
-- Procedimientos
--
CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_actualizarprecio` (IN `codigoprecio` INT, IN `codigo_items_reparto` INT, IN `monto` FLOAT, IN `km` INT)  begin
	#actualizamos la tabla items_reparto
	UPDATE items_reparto i 
	SET i.ID_Precio=codigoprecio
	WHERE i.ID_Items_Reparto=codigo_items_reparto;
    #actualizamos la tabla ficha y destino (monto y km)
    UPDATE items_reparto i INNER JOIN precio p ON(p.ID_Precio=i.ID_Precio) INNER JOIN ficha f ON (f.ID_Items_Reparto=i.ID_Items_Reparto) INNER JOIN destino d ON(d.ID_Destino=f.ID_Destino)
	SET f.Monto=monto , d.KM=km
	WHERE i.ID_Items_Reparto=codigo_items_reparto;
end$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Conductor_Envios_Disponibles` ()  BEGIN
    IF (SELECT COUNT(*) FROM ficha WHERE ficha.Estado = 'ASIGNADO') > 0 THEN
         SELECT ficha.ID_Ficha AS 'ID_FICHA',
        		ficha.ID_Empresa AS 'ID_EMPRESA', 
                ficha.Fecha_Creacion AS 'FECHA_CREACION' , 
                ficha.Estado AS 'ESTADO' , 
                ficha.Monto AS 'MONTO' , 
                ficha.Coord_origen AS 'COORD_ORIGEN', 
                ficha.Coord_destino AS 'COORD_DESTINO' , 
                ficha.KM AS 'KM' , 
                cuenta_empresa.Nombre_Comercial AS 'EMPRESA', 
                cuenta_empresa.Direccion 'DIR_ORIGEN', 
                cuenta_empresa.ID_Distrito AS 'ORIGEN_ID_DISTRITO',  
                destino.Direccion AS 'DIR_DESTINO', 
                destino.ID_Distrito AS 'DESTINO_ID_DISTRITO' , 
                tipo_envio.Tipo AS 'TIPO' , 
                items_reparto.Producto AS 'PRODUCTO', 
                comprador.Nombre AS 'CLIENTE_NOMBRE', 
                comprador.Apellido AS 'CLIENTE_APELLIDO' , 
                comprador.Celular AS 'CLIENTE_CELULAR'
            FROM ficha INNER JOIN destino ON ficha.ID_Destino = destino.ID_Destino 
            INNER JOIN tipo_envio ON ficha.ID_TipoEnvio = tipo_envio.ID_TipoEnvio
            INNER JOIN items_reparto ON ficha.ID_Items_Reparto = items_reparto.ID_Items_Reparto
            INNER JOIN comprador ON ficha.ID_Comprador = comprador.ID_Comprador
            INNER JOIN cuenta_empresa ON ficha.ID_Empresa = cuenta_empresa.ID_Empresa
            WHERE ficha.Estado = 'ASIGNADO';
        ELSE
        SELECT false;
    END IF ;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Conductor_Registrar_Usuario` (IN `IN_Nombre` VARCHAR(100), IN `IN_Apellido` VARCHAR(100), IN `IN_Email` VARCHAR(100), IN `IN_Celular` VARCHAR(9), IN `IN_Pass` VARCHAR(100), IN `IN_Tipo` VARCHAR(1), IN `IN_Terminos` VARCHAR(1))  BEGIN
	IF ( SELECT COUNT(Email) FROM cuenta_persona WHERE Email = IN_Email  COLLATE utf8_unicode_ci) < 1 THEN
    
    INSERT INTO cuenta_persona (Nombre,Apellido,Email, Celular,Passw,Tipo,Termino)
        VALUES ( IN_Nombre,IN_Apellido,IN_Email,IN_Celular,IN_Pass,IN_Tipo,IN_Terminos);
    	SELECT true;
    ELSE
    	SELECT false;
    END IF;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Actualizar_Usuario` (IN `IN_ID_Empresa` VARCHAR(255), IN `IN_Nombre_Comercial` VARCHAR(255), IN `IN_RUC` VARCHAR(255), IN `IN_Razon` VARCHAR(255), IN `IN_Direccion` VARCHAR(255), IN `IN_Interior` VARCHAR(255), IN `IN_ID_Distrito` VARCHAR(255), IN `IN_Email` VARCHAR(255), IN `IN_Celular` VARCHAR(255), IN `IN_Pass` VARCHAR(255), IN `IN_Tipo` VARCHAR(255), IN `IN_Terminos` VARCHAR(255))  BEGIN
	UPDATE cuenta_empresa SET 
	Nombre_Comercial =IN_Nombre_Comercial,
	RUC = IN_RUC,
	Razon = IN_Razon,
	Direccion = IN_Direccion,
	Interior = IN_Interior,
	ID_Distrito = IN_ID_Distrito,
	Email = IN_Email,
	Celular = IN_Celular,
	Pass = IN_Pass,
	Tipo = IN_Tipo,
	Terminos = IN_Terminos 
	WHERE ID_Empresa = IN_ID_Empresa;

	SELECT true;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Envios_Asignados` (IN `IN_IDEMPRESA` VARCHAR(255))  BEGIN
SELECT ficha.ID_Ficha AS 'ID_FICHA', ficha.ID_Empresa AS 'ID_EMPRESA' , ficha.Fecha_Creacion AS 'FECHA_CREACION' , ficha.Estado AS 'ESTADO' , ficha.Monto AS 'MONTO' , ficha.Coord_origen AS 'COORD_ORIGEN', ficha.Coord_destino AS 'COORD_DESTINO' , ficha.KM AS 'KM' , cuenta_empresa.Nombre_Comercial AS 'EMPRESA', cuenta_empresa.Direccion 'DIR_ORIGEN', cuenta_empresa.ID_Distrito AS 'ORIGEN_ID_DISTRITO',  destino.Direccion AS 'DIR_DESTINO', destino.ID_Distrito AS 'DESTINO_ID_DISTRITO' , tipo_envio.Tipo AS 'TIPO' , items_reparto.Producto AS 'PRODUCTO', comprador.Nombre AS 'CLIENTE_NOMBRE', comprador.Apellido AS 'CLIENTE_APELLIDO' , comprador.Celular AS 'CLIENTE_CELULAR'
    FROM ficha INNER JOIN destino ON ficha.ID_Destino = destino.ID_Destino 
    INNER JOIN tipo_envio ON ficha.ID_TipoEnvio = tipo_envio.ID_TipoEnvio
    INNER JOIN items_reparto ON ficha.ID_Items_Reparto = items_reparto.ID_Items_Reparto
    INNER JOIN comprador ON ficha.ID_Comprador = comprador.ID_Comprador
    INNER JOIN cuenta_empresa ON ficha.ID_Empresa = cuenta_empresa.ID_Empresa
    WHERE ficha.ID_Empresa = IN_IDEMPRESA AND ficha.Estado = 'ASIGNADO';
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Envios_Realizados` (IN `IN_IDEMPRESA` VARCHAR(255))  BEGIN
SELECT ficha.ID_Ficha AS 'ID_FICHA', ficha.ID_Empresa AS 'ID_EMPRESA' , ficha.Fecha_Creacion AS 'FECHA_CREACION' , ficha.Estado AS 'ESTADO' , ficha.Monto AS 'MONTO' , ficha.Coord_origen AS 'COORD_ORIGEN', ficha.Coord_destino AS 'COORD_DESTINO' , ficha.KM AS 'KM' , cuenta_empresa.Nombre_Comercial AS 'EMPRESA', cuenta_empresa.Direccion 'DIR_ORIGEN', cuenta_empresa.ID_Distrito AS 'ORIGEN_ID_DISTRITO',  destino.Direccion AS 'DIR_DESTINO', destino.ID_Distrito AS 'DESTINO_ID_DISTRITO' , tipo_envio.Tipo AS 'TIPO' , items_reparto.Producto AS 'PRODUCTO', comprador.Nombre AS 'CLIENTE_NOMBRE', comprador.Apellido AS 'CLIENTE_APELLIDO' , comprador.Celular AS 'CLIENTE_CELULAR'
    FROM ficha INNER JOIN destino ON ficha.ID_Destino = destino.ID_Destino 
    INNER JOIN tipo_envio ON ficha.ID_TipoEnvio = tipo_envio.ID_TipoEnvio
    INNER JOIN items_reparto ON ficha.ID_Items_Reparto = items_reparto.ID_Items_Reparto
    INNER JOIN comprador ON ficha.ID_Comprador = comprador.ID_Comprador
    INNER JOIN cuenta_empresa ON ficha.ID_Empresa = cuenta_empresa.ID_Empresa
    WHERE ficha.ID_Empresa = IN_IDEMPRESA AND ficha.Estado = 'REALIZADO';
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Login` (IN `IN_CORREO` VARCHAR(60), IN `IN_PASS` VARCHAR(60))  BEGIN
	SELECT C.ID_Cuenta_Persona AS 'ID',C.Nombre AS 'NOMBRE',C.Apellido AS 'APELLIDO',C.Email AS 'CORREO',C.Fecha_Registro AS 'FECHA_REGISTRO',C.Tipo AS 'TIPO', C.Termino AS 'STATUS' ,C.Celular AS 'CELULAR' FROM cuenta_persona AS C WHERE Email = IN_CORREO and Passw = IN_PASS;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Registrar_Envio` (IN `nombre` VARCHAR(255), IN `apellido` VARCHAR(255), IN `documento` VARCHAR(255), IN `celular` VARCHAR(255), IN `direccion` VARCHAR(255), IN `id_distrito` VARCHAR(255), IN `producto` VARCHAR(255), IN `descripcion` VARCHAR(255), IN `SizeProduct` VARCHAR(255), IN `delicado` VARCHAR(255), IN `idtipoenvio` VARCHAR(255), IN `idempresa` VARCHAR(255), IN `estado` VARCHAR(255), IN `kilometros` VARCHAR(255), IN `coordenada_origen` VARCHAR(255), IN `coordenada_destino` VARCHAR(255), IN `IN_MONTO` VARCHAR(255))  BEGIN 
	declare autoComprador int;
    declare autoDestino int;
    declare autoProducto int;
    declare aux1 int;
    declare aux2 int;

		INSERT INTO comprador (Nombre,Apellido,Documento,Celular,FechaCierre) 
        		VALUES (nombre,apellido,documento,celular,'0000-00-00 00:00:00');
                
		INSERT INTO destino (Direccion,ID_Distrito) 
        		VALUES (direccion,id_distrito);
                
		INSERT INTO items_reparto (Producto,Delicado,Descripcion,tamaño) 
        		VALUES (producto,delicado,descripcion,SizeProduct);
    
    set autoComprador=(SELECT MAX(ID_Comprador) AS id FROM  comprador);
    set autoDestino=(SELECT MAX(ID_Destino) AS id FROM  destino);
    set autoProducto=(SELECT MAX(ID_Items_Reparto) AS id FROM items_reparto);

    set aux1=(SELECT MAX(ID_Ficha) AS id FROM ficha);
                
		INSERT INTO ficha (ID_Destino, ID_TipoEnvio, ID_Items_Reparto, ID_Empresa, ID_Comprador, Estado, Coord_origen,	Coord_destino,	KM, MONTO)
                VALUES (autoDestino, idtipoenvio, autoProducto, idempresa, autoComprador, estado, coordenada_origen ,  coordenada_destino ,kilometros, IN_MONTO);

    set aux2=(SELECT MAX(ID_Ficha) AS id FROM ficha);

    IF ( aux2 > aux1 ) then
    	SELECT true;
    ELSE
    	SELECT false;
    END IF ;

END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Empresa_Registrar_Usuario` (IN `IN_Nombre_Comercial` VARCHAR(100), IN `IN_RUC` VARCHAR(20), IN `IN_Razon` VARCHAR(100), IN `IN_Direccion` VARCHAR(100), IN `IN_Interior` VARCHAR(4), IN `IN_ID_Distrito` VARCHAR(3), IN `IN_Email` VARCHAR(100), IN `IN_Celular` VARCHAR(9), IN `IN_Pass` VARCHAR(100), IN `IN_Tipo` VARCHAR(1), IN `IN_Terminos` VARCHAR(1))  BEGIN
	IF ( SELECT COUNT(Email) FROM cuenta_empresa WHERE Email = IN_Email  COLLATE utf8_unicode_ci) < 1 THEN 
    INSERT INTO cuenta_empresa ( Nombre_Comercial, RUC, Razon, Direccion, Interior, ID_Distrito, Email, Celular, Pass, Tipo, Terminos)
        VALUES ( IN_Nombre_Comercial,IN_RUC,IN_Razon,IN_Direccion,IN_Interior,IN_ID_Distrito,IN_Email,IN_Celular,IN_Pass,IN_Tipo,IN_Terminos);
    	SELECT true;
    ELSE
    	SELECT false;
    END IF;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_App_Login` (IN `IN_CORREO` VARCHAR(60), IN `IN_PASS` VARCHAR(60))  BEGIN
	IF (SELECT COUNT(ID_Cuenta_Persona) FROM cuenta_persona AS C WHERE Email = IN_CORREO   COLLATE utf8_unicode_ci and Passw = IN_PASS   COLLATE utf8_unicode_ci) > 0 then
    	SELECT C.ID_Cuenta_Persona AS 'ID',C.Nombre AS 'NOMBRE',C.Apellido AS 'APELLIDO',C.Email AS 'CORREO',C.Fecha_Registro AS 'FECHA_REGISTRO',C.Tipo AS 'TIPO', C.Termino AS 'STATUS' ,C.Celular AS 'CELULAR' FROM cuenta_persona AS C WHERE Email = IN_CORREO   COLLATE utf8_unicode_ci and Passw = IN_PASS   COLLATE utf8_unicode_ci;
    ELSEIF (SELECT COUNT(ID_Empresa) FROM cuenta_empresa  WHERE Email = IN_CORREO   COLLATE utf8_unicode_ci and Pass = IN_PASS   COLLATE utf8_unicode_ci) > 0 then
    	SELECT C.ID_Empresa AS 'ID',C.Nombre_Comercial AS 'NOMBRE',C.Razon AS 'RAZON',C.Email AS 'CORREO',C.Fecha AS 'FECHA_REGISTRO',C.Tipo AS 'TIPO', C.Terminos AS 'STATUS' ,C.Celular AS 'CELULAR' FROM cuenta_empresa AS C WHERE Email = IN_CORREO   COLLATE utf8_unicode_ci and Pass = IN_PASS   COLLATE utf8_unicode_ci ;
        ELSE
        SELECT false;
    END IF ;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_Condu_Actualizar_CambiarEstado` (IN `identrega` INT, IN `estado` VARCHAR(15))  BEGIN 
	#Cierra el pedido a entregado
	update entrega e INNER JOIN ficha f ON (e.ID_Ficha=f.ID_Ficha)
    set f.Estado = estado, e.Fecha_Entrega=now()
    WHERE ID_Entrega = identrega;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_Condu_Crear_AsignarProducto` (IN `idvehiculo` INT, IN `idficha` INT, IN `estado` VARCHAR(15))  BEGIN 
 INSERT INTO entrega (ID_Vehiculo,ID_Ficha) VALUES (idvehiculo,idficha);
 #ACTULIZAR TABLA FICHA
 UPDATE ficha 
 SET Estado = estado
 WHERE ID_Ficha = idficha;
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_Condu_Crear_FichaColaborador` (IN `Nombre_` VARCHAR(40), IN `Apellido_` VARCHAR(40), IN `Documento_` VARCHAR(8), IN `Sexo_` CHAR(1), IN `Direccion_` VARCHAR(50), IN `FechaNacimiento` DATE, IN `id_ccuenta` INT, IN `tuc_` VARCHAR(15), IN `numLicencia_` VARCHAR(10), IN `fechaExpLicencia_` DATE, IN `numPoliza_` VARCHAR(15), IN `FechaVenSoat_` DATE, IN `codCitv_` INT, IN `nivel_` CHAR(10))  begin
	declare auto int;
    set auto=(select count(*)+1 from persona);
	insert into persona (Nombre,Apellido,Documento,Sexo,Direccion,Fecha_Nacimiento,ID_Cuenta_Persona) values
    (Nombre_,Apellido_,Documento_,Sexo_,Direccion_,FechaNacimiento,id_ccuenta);
    
      insert into chofer (TUC,Num_Licencia,Fecha_Expedicion_Licencia,Num_Poliza,Fecha_Venc_Soat,
    COD_CITV,Nivel,ID_Usuario) values(tuc_,numLicencia_,fechaExpLicencia_,numPoliza_,FechaVenSoat_,codCitv_,nivel_,auto);

end$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_Empresa_Crear_Cuenta` (IN `nombre` VARCHAR(20), IN `razon` VARCHAR(20), IN `ruc` VARCHAR(11), IN `email` VARCHAR(30), IN `direccion` VARCHAR(40), IN `interior` CHAR(5), IN `celular` VARCHAR(9), IN `pass` VARCHAR(60), IN `tipo` INT, IN `terminos` INT)  BEGIN 
    INSERT INTO cuenta_empresa (Nombre_Comercial,Razon,RUC,Email,Direccion,Interior,Celular,Pass,Tipo,Terminos) VALUES (nombre,razon,ruc,email,direccion,interior,celular,pass,tipo,terminos);
END$$

CREATE DEFINER=`id16797125_root`@`%` PROCEDURE `usp_Empresa_Crear_Ficha` (IN `nombre` VARCHAR(30), IN `apellido` VARCHAR(30), IN `documento` VARCHAR(8), IN `celular` VARCHAR(9), IN `direccion` VARCHAR(40), IN `id_distrito` INT, IN `producto` VARCHAR(60), IN `delicado` CHAR(2), IN `descripcion` TEXT, IN `idtipoenvio` INT, IN `idempresa` INT, IN `estado` VARCHAR(15))  BEGIN 
	declare autoComprador int;
    declare autoDestino int;
    declare autoProducto int;
    
    set autoComprador=(select count(*)+1 from comprador);
    set autoDestino=(select count(*)+1 from destino);
    set autoProducto=(select count(*)+1 from items_reparto);

		INSERT INTO comprador (Nombre,Apellido,Documento,Celular) VALUES (nombre,apellido,documento,celular);
		INSERT INTO destino (Direccion,ID_Distrito) VALUES (direccion,id_distrito);
		INSERT INTO items_reparto (Producto,Delicado,Descripcion) VALUES (producto,delicado,descripcion);
		INSERT INTO ficha (ID_Destino,ID_TipoEnvio ,ID_Items_Reparto, ID_Empresa,ID_Comprador, Estado)
			VALUES (autoDestino,idtipoenvio, autoProducto, idempresa,autoComprador, estado);

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `chofer`
--

CREATE TABLE `chofer` (
  `ID_Chofer` int(11) NOT NULL,
  `TUC` varchar(15) DEFAULT NULL,
  `Num_Licencia` varchar(10) DEFAULT NULL,
  `Fecha_Expedicion_Licencia` date DEFAULT NULL,
  `Num_Poliza` varchar(15) DEFAULT NULL,
  `Fecha_Venc_Soat` date DEFAULT NULL,
  `COD_CITV` int(11) DEFAULT NULL,
  `Nivel` char(10) DEFAULT NULL,
  `ID_Usuario` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `chofer`
--

INSERT INTO `chofer` (`ID_Chofer`, `TUC`, `Num_Licencia`, `Fecha_Expedicion_Licencia`, `Num_Poliza`, `Fecha_Venc_Soat`, `COD_CITV`, `Nivel`, `ID_Usuario`) VALUES
(1, '4C5AS4C65', '654VDS5', '2021-01-01', '45ASC', '2021-12-31', 0, 'A2', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comprador`
--

CREATE TABLE `comprador` (
  `ID_Comprador` int(11) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Apellido` varchar(30) NOT NULL,
  `Documento` varchar(8) NOT NULL,
  `Celular` varchar(9) NOT NULL,
  `FechaApertura` datetime NOT NULL DEFAULT current_timestamp(),
  `FechaCierre` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `comprador`
--

INSERT INTO `comprador` (`ID_Comprador`, `Nombre`, `Apellido`, `Documento`, `Celular`, `FechaApertura`, `FechaCierre`) VALUES
(1, 'PIERO', 'DIAZ', '12444444', '998855555', '2021-05-25 21:45:20', '0000-00-00 00:00:00'),
(2, 'CLAUDIA', 'DIAZ', '12547777', '998558789', '2021-05-25 21:47:07', '0000-00-00 00:00:00'),
(3, 'TITO', 'YANAC', '45444444', '999985588', '2021-05-25 22:59:56', '0000-00-00 00:00:00'),
(4, 'MARIA', 'ROSALES', '47777777', '98788888', '2021-06-02 20:31:49', '0000-00-00 00:00:00'),
(5, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:12:28', '0000-00-00 00:00:00'),
(6, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:12:35', '0000-00-00 00:00:00'),
(7, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:34:31', '0000-00-00 00:00:00'),
(8, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:38:56', '0000-00-00 00:00:00'),
(9, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:38:58', '0000-00-00 00:00:00'),
(10, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:39:17', '0000-00-00 00:00:00'),
(11, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:40:21', '0000-00-00 00:00:00'),
(12, 'armando', 'paredez', '64961961', '984161891', '2021-06-16 22:41:20', '0000-00-00 00:00:00'),
(13, 'ricardo', 'montoya', '68645981', '981651615', '2021-06-17 23:02:23', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_bancaria`
--

CREATE TABLE `cuenta_bancaria` (
  `ID_Cuenta` int(11) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `Banco` varchar(20) NOT NULL,
  `CU` varchar(12) NOT NULL,
  `CCI` varchar(20) NOT NULL,
  `Fecha` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuenta_bancaria`
--

INSERT INTO `cuenta_bancaria` (`ID_Cuenta`, `ID_Usuario`, `Banco`, `CU`, `CCI`, `Fecha`) VALUES
(11, 1, 'BCP', '156456465451', '4484546548945165', '2021-05-25 22:56:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_empresa`
--

CREATE TABLE `cuenta_empresa` (
  `ID_Empresa` int(11) NOT NULL,
  `Nombre_Comercial` varchar(20) CHARACTER SET utf8 NOT NULL,
  `Razon` varchar(20) CHARACTER SET utf8 NOT NULL,
  `RUC` varchar(11) CHARACTER SET utf8 NOT NULL,
  `Email` varchar(30) CHARACTER SET utf8 NOT NULL,
  `Direccion` varchar(40) CHARACTER SET utf8 NOT NULL,
  `Interior` char(5) CHARACTER SET utf8 NOT NULL,
  `Celular` varchar(9) CHARACTER SET utf8 NOT NULL,
  `Pass` varchar(60) CHARACTER SET utf8 NOT NULL,
  `Tipo` int(11) NOT NULL,
  `Fecha` date NOT NULL DEFAULT current_timestamp(),
  `Terminos` int(11) NOT NULL,
  `ID_Distrito` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Volcado de datos para la tabla `cuenta_empresa`
--

INSERT INTO `cuenta_empresa` (`ID_Empresa`, `Nombre_Comercial`, `Razon`, `RUC`, `Email`, `Direccion`, `Interior`, `Celular`, `Pass`, `Tipo`, `Fecha`, `Terminos`, `ID_Distrito`) VALUES
(1, 'VIDEMA', 'VIDEMA', '78955555555', 'VIDEMA@GMAIL.COM', 'CALLE LAS FLORES', '2B', '999999991', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1, '2021-05-22', 1, 0),
(2, 'NORKYS', 'POLLERIA', '55555555555', 'NORKYS@GMAIL.COM', 'CALLE LAS VEGAS', '1B', '999999999', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1, '2021-06-01', 1, 0),
(3, 'Oechsle', 'TIENDAS PERUANAS S.A', '20493020618', 'oeschle@gmail.com', 'Av. Aviación 2405', '0', '957689483', '40bd001563085fc35165329ea1ff5c5ecbdbbeef', 1, '2021-06-16', 1, 30);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cuenta_persona`
--

CREATE TABLE `cuenta_persona` (
  `ID_Cuenta_Persona` int(11) NOT NULL,
  `Nombre` varchar(40) NOT NULL,
  `Apellido` varchar(40) NOT NULL,
  `Email` varchar(30) NOT NULL,
  `Celular` int(9) NOT NULL,
  `Passw` varchar(60) NOT NULL,
  `Fecha_Registro` date DEFAULT current_timestamp(),
  `Tipo` int(11) NOT NULL,
  `Termino` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `cuenta_persona`
--

INSERT INTO `cuenta_persona` (`ID_Cuenta_Persona`, `Nombre`, `Apellido`, `Email`, `Celular`, `Passw`, `Fecha_Registro`, `Tipo`, `Termino`) VALUES
(1, 'PATRICK ', 'DIAZ VASQUEZ', 'PADV1988@GMAIL.COM', 0, '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2021-05-24', 0, 1),
(2, 'CLAUDIA', 'DIAZ', 'CLAUDIA@GMAIL.COM', 0, '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2021-06-01', 0, 1),
(3, 'juan', 'perez', 'juanperez@gmail.com', 654978654, '123', '2021-06-16', 0, 1),
(4, 'roberto', 'palacios', 'rp@gmail.com', 951874658, '123', '2021-06-16', 0, 1),
(5, 'tito jesús', 'yánac saldaña', 'titoyanac@gmail.com', 970576076, '40bd001563085fc35165329ea1ff5c5ecbdbbeef', '2021-06-16', 0, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destino`
--

CREATE TABLE `destino` (
  `ID_Destino` int(11) NOT NULL,
  `Direccion` varchar(40) DEFAULT NULL,
  `KM` int(11) DEFAULT NULL,
  `ID_Distrito` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='	';

--
-- Volcado de datos para la tabla `destino`
--

INSERT INTO `destino` (`ID_Destino`, `Direccion`, `KM`, `ID_Distrito`) VALUES
(8, 'av. wiesse 1449', NULL, 31),
(9, 'av. wiesse 1449', NULL, 31),
(10, 'av. wiesse 1449', NULL, 31),
(11, 'av. wiesse 1449', NULL, 31),
(12, 'av. wiesse 1449', NULL, 31),
(13, 'av. surco 682', NULL, 27);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `distrito`
--

CREATE TABLE `distrito` (
  `ID_Distrito` int(11) NOT NULL,
  `Nombre` varchar(50) COLLATE utf8_esperanto_ci NOT NULL,
  `ID_Provincia` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_esperanto_ci;

--
-- Volcado de datos para la tabla `distrito`
--

INSERT INTO `distrito` (`ID_Distrito`, `Nombre`, `ID_Provincia`) VALUES
(1, 'Ancón', 1),
(2, 'Ate Vitarte', 1),
(3, 'Barranco', 1),
(4, 'Breña', 1),
(5, 'Carabayllo', 1),
(6, 'Chaclacayo', 1),
(7, 'Chorrillos', 1),
(8, 'Cieneguilla', 1),
(9, 'Comas', 1),
(10, 'El Agustino', 1),
(11, 'Independencia', 1),
(12, 'Jesús María', 1),
(13, 'La Molina', 1),
(14, 'La Victoria', 1),
(15, 'Cercado de Lima', 1),
(16, 'Lince', 1),
(17, 'Los Olivos', 1),
(18, 'Lurigancho', 1),
(19, 'Lurín', 1),
(23, 'Magdalena del Mar', 1),
(24, 'Miraflores', 1),
(25, 'Pachacamac', 1),
(26, 'Pucusana', 1),
(27, 'Pueblo Libre', 1),
(28, 'Puente Piedra', 1),
(29, 'Punta Hermosa', 1),
(30, 'Punta Negra', 1),
(31, 'Rímac', 1),
(32, 'San Bartolo', 1),
(33, 'San Borja', 1),
(34, 'San Isidro', 1),
(35, 'San Juan de Lurigancho', 1),
(36, 'San Juan de Miraflores', 1),
(37, 'San Luis', 1),
(38, 'San Martín de Porres', 1),
(39, 'San Miguel', 1),
(40, 'Santa Anita', 1),
(41, 'Santa María del Mar', 1),
(42, 'Santa Rosa', 1),
(43, 'Santiago de Surco', 1),
(44, 'Surquillo', 1),
(45, 'Villa El Salvador', 1),
(46, 'Villa María del Triunfo', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `entrega`
--

CREATE TABLE `entrega` (
  `ID_Entrega` int(11) NOT NULL,
  `ID_Vehiculo` int(11) NOT NULL,
  `ID_Ficha` int(11) NOT NULL,
  `Fecha_Recepcion` datetime NOT NULL DEFAULT current_timestamp(),
  `Fecha_Entrega` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado`
--

CREATE TABLE `estado` (
  `ID_Estado` int(11) NOT NULL,
  `Descripcion` text NOT NULL,
  `ID_Items_Reparto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `estado_conductor`
--

CREATE TABLE `estado_conductor` (
  `ID_Estado` int(11) NOT NULL,
  `Estado` varchar(15) NOT NULL,
  `ID_Usuario` int(11) NOT NULL,
  `Actividad` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ficha`
--

CREATE TABLE `ficha` (
  `ID_Ficha` int(11) NOT NULL,
  `ID_Destino` int(11) DEFAULT NULL,
  `ID_TipoEnvio` int(11) DEFAULT NULL,
  `ID_Items_Reparto` int(11) DEFAULT NULL,
  `ID_Empresa` int(11) DEFAULT NULL,
  `ID_Comprador` int(11) DEFAULT NULL,
  `Fecha_Creacion` datetime DEFAULT current_timestamp(),
  `Estado` varchar(15) NOT NULL,
  `Monto` float DEFAULT NULL,
  `Coord_origen` varchar(60) DEFAULT NULL,
  `Coord_destino` varchar(60) DEFAULT NULL,
  `KM` decimal(8,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `ficha`
--

INSERT INTO `ficha` (`ID_Ficha`, `ID_Destino`, `ID_TipoEnvio`, `ID_Items_Reparto`, `ID_Empresa`, `ID_Comprador`, `Fecha_Creacion`, `Estado`, `Monto`, `Coord_origen`, `Coord_destino`, `KM`) VALUES
(5, 8, 3, 5, 3, 8, '2021-06-16 22:38:56', 'REALIZADO', 15, '-12.02884783143227 , -77.00398251414299', '-12.004135395368666 , -77.00698692351578', 3.30),
(6, 9, 3, 6, 3, 9, '2021-06-16 22:38:58', 'REALIZADO', 15, '-12.02884783143227 , -77.00398251414299', '-12.004135395368666 , -77.00698692351578', 3.30),
(7, 10, 3, 7, 3, 10, '2021-06-16 22:39:17', 'REALIZADO', 15, '-12.02884783143227 , -77.00398251414299', '-12.004135395368666 , -77.00698692351578', 3.30),
(8, 11, 3, 8, 3, 11, '2021-06-16 22:40:21', 'ASIGNADO', 15, '-12.02884783143227 , -77.00398251414299', '-12.004135395368666 , -77.00698692351578', 3.30),
(9, 12, 3, 9, 3, 12, '2021-06-16 22:41:20', 'ASIGNADO', 15, '-12.02884783143227 , -77.00398251414299', '-12.004135395368666 , -77.00698692351578', 3.30),
(10, 13, 2, 10, 3, 13, '2021-06-17 23:02:23', 'ASIGNADO', 15, '-12.038776240294577 , -76.99746742844582', '-12.045838179029092 , -77.01973613351583', 3.90);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `items_reparto`
--

CREATE TABLE `items_reparto` (
  `ID_Items_Reparto` int(11) NOT NULL,
  `Producto` varchar(60) DEFAULT NULL,
  `Delicado` char(2) DEFAULT NULL,
  `Descripcion` text DEFAULT NULL,
  `ID_Precio` int(11) DEFAULT NULL,
  `tamaño` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `items_reparto`
--

INSERT INTO `items_reparto` (`ID_Items_Reparto`, `Producto`, `Delicado`, `Descripcion`, `ID_Precio`, `tamaño`) VALUES
(1, 'MONITOR', 'SI', 'MONITOR LG 50 PUL VALOR 250 SOLES', NULL, ''),
(2, 'CELULAR', 'SI', 'CELULAR + CARGADOR + AURICULARES NUEVO EN CAJA', NULL, ''),
(3, 'ZAPATILLA', 'NO', 'ZAPATILLA NIKE TALLA L', NULL, ''),
(4, 'MOCHILA', 'SI', 'MOCHILA PARA NIñA', NULL, ''),
(5, 'ropero', 'si', 'ropero grande', NULL, 'grande'),
(6, 'ropero', 'si', 'ropero grande', NULL, 'grande'),
(7, 'ropero', 'si', 'ropero grande', NULL, 'grande'),
(8, 'ropero', 'si', 'ropero grande', NULL, 'grande'),
(9, 'ropero', 'si', 'ropero grande', NULL, 'grande'),
(10, 'bicicleta', 'no', 'aro 40', NULL, 'grande');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestroacceso`
--

CREATE TABLE `maestroacceso` (
  `IdAcceso` int(11) NOT NULL,
  `IdConductor` int(11) NOT NULL,
  `FechRegistro` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestrobreved`
--

CREATE TABLE `maestrobreved` (
  `IdBreved` int(11) NOT NULL,
  `IdCond` int(11) NOT NULL,
  `IdCategoria` int(11) NOT NULL,
  `FecExpedision` datetime NOT NULL,
  `FecRenovacion` datetime NOT NULL,
  `FileDocu` text NOT NULL,
  `Foto` text NOT NULL,
  `NroLicencia` int(11) NOT NULL,
  `IdRevision` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestrocategoria`
--

CREATE TABLE `maestrocategoria` (
  `IdCategoria` int(11) NOT NULL,
  `Categoria` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestrofactura`
--

CREATE TABLE `maestrofactura` (
  `Idcobros` int(11) NOT NULL,
  `IdEmpresa` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `CantidadEnvio` int(11) NOT NULL,
  `EstadoFactura` varchar(10) NOT NULL,
  `Descuento` float NOT NULL,
  `Contexto` text NOT NULL,
  `IGV` float NOT NULL,
  `Monto` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestropago`
--

CREATE TABLE `maestropago` (
  `ID_Pagos` int(11) NOT NULL,
  `ID_Ususario` int(11) NOT NULL,
  `ID_TipoEnvio` int(11) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp(),
  `Monto` float NOT NULL,
  `Descuento` float NOT NULL,
  `Bonificacion` float NOT NULL,
  `NumEntrTardias` int(11) NOT NULL,
  `NumEntrJustificada` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `maestrorevision`
--

CREATE TABLE `maestrorevision` (
  `IdRevision` int(11) NOT NULL,
  `EstadoRevision` char(2) NOT NULL,
  `Fecha` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `Direccion` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `persona`
--

CREATE TABLE `persona` (
  `ID_Usuario` int(11) NOT NULL,
  `Nombre` varchar(40) DEFAULT NULL,
  `Apellido` varchar(40) DEFAULT NULL,
  `Documento` varchar(8) DEFAULT NULL,
  `Sexo` char(1) DEFAULT NULL,
  `Direccion` varchar(50) DEFAULT NULL,
  `Fecha_Nacimiento` date DEFAULT NULL,
  `ID_Cuenta_Persona` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `persona`
--

INSERT INTO `persona` (`ID_Usuario`, `Nombre`, `Apellido`, `Documento`, `Sexo`, `Direccion`, `Fecha_Nacimiento`, `ID_Cuenta_Persona`) VALUES
(1, 'PATRICK', 'DIAZ VASQUEZ', '12111111', 'M', 'CALLE 8', '1988-04-15', 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `precio`
--

CREATE TABLE `precio` (
  `ID_Precio` int(11) NOT NULL,
  `Precio` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `precio`
--

INSERT INTO `precio` (`ID_Precio`, `Precio`) VALUES
(1, 2),
(2, 3),
(3, 4);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `provincia`
--

CREATE TABLE `provincia` (
  `ID_Provincia` int(11) NOT NULL,
  `Nombre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `provincia`
--

INSERT INTO `provincia` (`ID_Provincia`, `Nombre`) VALUES
(1, 'LIMA'),
(2, 'IQUITOS'),
(3, 'TARAPOTO'),
(4, 'ANCASH');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_envio`
--

CREATE TABLE `tipo_envio` (
  `ID_TipoEnvio` int(11) NOT NULL,
  `Tipo` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `tipo_envio`
--

INSERT INTO `tipo_envio` (`ID_TipoEnvio`, `Tipo`) VALUES
(1, 'EXPRESS'),
(2, 'SAME DAY'),
(3, 'NEXT DAY');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_vehiculo`
--

CREATE TABLE `tipo_vehiculo` (
  `ID_Tipo` int(11) NOT NULL,
  `Marca` varchar(20) NOT NULL,
  `Modelo` varchar(20) NOT NULL,
  `Estado` char(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 KEY_BLOCK_SIZE=1;

--
-- Volcado de datos para la tabla `tipo_vehiculo`
--

INSERT INTO `tipo_vehiculo` (`ID_Tipo`, `Marca`, `Modelo`, `Estado`) VALUES
(1, 'VOLVO', 'SEDAN S60', 'ACTIVO'),
(2, 'HIUDAN', 'NISSAN', 'ACTIVO');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `vehiculo`
--

CREATE TABLE `vehiculo` (
  `ID_Vehiculo` int(11) NOT NULL,
  `Num_Placa` char(6) NOT NULL,
  `Num_Serie` varchar(15) NOT NULL,
  `Num_Vin` varchar(15) NOT NULL,
  `Num_Motor` varchar(15) NOT NULL,
  `Color` varchar(15) NOT NULL,
  `Anotaciones` text NOT NULL,
  `Placa_Vigente` char(2) NOT NULL,
  `Placa_Anterior` char(6) NOT NULL,
  `ID_Chofer` int(11) NOT NULL,
  `ID_Tipo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `vehiculo`
--

INSERT INTO `vehiculo` (`ID_Vehiculo`, `Num_Placa`, `Num_Serie`, `Num_Vin`, `Num_Motor`, `Color`, `Anotaciones`, `Placa_Vigente`, `Placa_Anterior`, `ID_Chofer`, `ID_Tipo`) VALUES
(1, 'A4ASA', '654654654', 'CAS564', '7CAS897', 'NEGRO', 'AUTO NUEVO', 'SI', 'ACS', 1, 2);

-- --------------------------------------------------------

--
-- Estructura Stand-in para la vista `View_App_Envios`
-- (Véase abajo para la vista actual)
--
CREATE TABLE `View_App_Envios` (
`ID_FICHA` int(11)
,`ID_EMPRESA` int(11)
,`FECHA_CREACION` datetime
,`ESTADO` varchar(15)
,`MONTO` float
,`COORD_ORIGEN` varchar(60)
,`COORD_DESTINO` varchar(60)
,`KM` decimal(8,2)
,`EMPRESA` varchar(20)
,`DIR_ORIGEN` varchar(40)
,`ORIGEN_ID_DISTRITO` int(11)
,`DIR_DESTINO` varchar(40)
,`DESTINO_ID_DISTRITO` int(11)
,`TIPO` varchar(40)
,`PRODUCTO` varchar(60)
,`CLIENTE_NOMBRE` varchar(30)
,`CLIENTE_APELLIDO` varchar(30)
,`CLIENTE_CELULAR` varchar(9)
);

-- --------------------------------------------------------

--
-- Estructura para la vista `View_App_Envios`
--
DROP TABLE IF EXISTS `View_App_Envios`;

CREATE ALGORITHM=UNDEFINED DEFINER=`id16797125_root`@`%` SQL SECURITY DEFINER VIEW `View_App_Envios`  AS  select `ficha`.`ID_Ficha` AS `ID_FICHA`,`ficha`.`ID_Empresa` AS `ID_EMPRESA`,`ficha`.`Fecha_Creacion` AS `FECHA_CREACION`,`ficha`.`Estado` AS `ESTADO`,`ficha`.`Monto` AS `MONTO`,`ficha`.`Coord_origen` AS `COORD_ORIGEN`,`ficha`.`Coord_destino` AS `COORD_DESTINO`,`ficha`.`KM` AS `KM`,`cuenta_empresa`.`Nombre_Comercial` AS `EMPRESA`,`cuenta_empresa`.`Direccion` AS `DIR_ORIGEN`,`cuenta_empresa`.`ID_Distrito` AS `ORIGEN_ID_DISTRITO`,`destino`.`Direccion` AS `DIR_DESTINO`,`destino`.`ID_Distrito` AS `DESTINO_ID_DISTRITO`,`tipo_envio`.`Tipo` AS `TIPO`,`items_reparto`.`Producto` AS `PRODUCTO`,`comprador`.`Nombre` AS `CLIENTE_NOMBRE`,`comprador`.`Apellido` AS `CLIENTE_APELLIDO`,`comprador`.`Celular` AS `CLIENTE_CELULAR` from (((((`ficha` join `destino` on(`ficha`.`ID_Destino` = `destino`.`ID_Destino`)) join `tipo_envio` on(`ficha`.`ID_TipoEnvio` = `tipo_envio`.`ID_TipoEnvio`)) join `items_reparto` on(`ficha`.`ID_Items_Reparto` = `items_reparto`.`ID_Items_Reparto`)) join `comprador` on(`ficha`.`ID_Comprador` = `comprador`.`ID_Comprador`)) join `cuenta_empresa` on(`ficha`.`ID_Empresa` = `cuenta_empresa`.`ID_Empresa`)) where `ficha`.`Estado` = 'ASIGNADO' ;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `chofer`
--
ALTER TABLE `chofer`
  ADD PRIMARY KEY (`ID_Chofer`),
  ADD UNIQUE KEY `TUC` (`TUC`),
  ADD UNIQUE KEY `Num_Licencia` (`Num_Licencia`),
  ADD UNIQUE KEY `Num_Poliza` (`Num_Poliza`),
  ADD UNIQUE KEY `Fecha_Venc_Soat` (`Fecha_Venc_Soat`),
  ADD KEY `chofer_ibfk_1` (`ID_Usuario`);

--
-- Indices de la tabla `comprador`
--
ALTER TABLE `comprador`
  ADD PRIMARY KEY (`ID_Comprador`);

--
-- Indices de la tabla `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  ADD PRIMARY KEY (`ID_Cuenta`),
  ADD KEY `ID_Usuario` (`ID_Usuario`);

--
-- Indices de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  ADD PRIMARY KEY (`ID_Empresa`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indices de la tabla `cuenta_persona`
--
ALTER TABLE `cuenta_persona`
  ADD PRIMARY KEY (`ID_Cuenta_Persona`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indices de la tabla `destino`
--
ALTER TABLE `destino`
  ADD PRIMARY KEY (`ID_Destino`),
  ADD KEY `destino_ibfk_1` (`ID_Distrito`);

--
-- Indices de la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD PRIMARY KEY (`ID_Distrito`),
  ADD KEY `distrito_ibfk_1` (`ID_Provincia`);

--
-- Indices de la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD PRIMARY KEY (`ID_Entrega`),
  ADD KEY `ID_Vehiculo` (`ID_Vehiculo`),
  ADD KEY `ID_Ficha` (`ID_Ficha`);

--
-- Indices de la tabla `estado`
--
ALTER TABLE `estado`
  ADD PRIMARY KEY (`ID_Estado`),
  ADD KEY `ID_Items_Reparto` (`ID_Items_Reparto`);

--
-- Indices de la tabla `estado_conductor`
--
ALTER TABLE `estado_conductor`
  ADD PRIMARY KEY (`ID_Estado`),
  ADD KEY `estado_conductor_ibfk_1` (`ID_Usuario`);

--
-- Indices de la tabla `ficha`
--
ALTER TABLE `ficha`
  ADD PRIMARY KEY (`ID_Ficha`),
  ADD KEY `ID_TipoEnvio` (`ID_TipoEnvio`),
  ADD KEY `ID_Empresa` (`ID_Empresa`),
  ADD KEY `ID_Items_Reparto` (`ID_Items_Reparto`),
  ADD KEY `ID_Destino` (`ID_Destino`),
  ADD KEY `ID_Comprador` (`ID_Comprador`) USING BTREE;

--
-- Indices de la tabla `items_reparto`
--
ALTER TABLE `items_reparto`
  ADD PRIMARY KEY (`ID_Items_Reparto`),
  ADD KEY `ID_Precio` (`ID_Precio`) USING BTREE;

--
-- Indices de la tabla `maestroacceso`
--
ALTER TABLE `maestroacceso`
  ADD PRIMARY KEY (`IdAcceso`),
  ADD KEY `IdConductor` (`IdConductor`);

--
-- Indices de la tabla `maestrobreved`
--
ALTER TABLE `maestrobreved`
  ADD PRIMARY KEY (`IdBreved`),
  ADD KEY `IdCategoria` (`IdCategoria`),
  ADD KEY `IdRevision` (`IdRevision`),
  ADD KEY `IdCond` (`IdCond`);

--
-- Indices de la tabla `maestrocategoria`
--
ALTER TABLE `maestrocategoria`
  ADD PRIMARY KEY (`IdCategoria`);

--
-- Indices de la tabla `maestrofactura`
--
ALTER TABLE `maestrofactura`
  ADD PRIMARY KEY (`Idcobros`),
  ADD KEY `IdEmpresa` (`IdEmpresa`);

--
-- Indices de la tabla `maestropago`
--
ALTER TABLE `maestropago`
  ADD PRIMARY KEY (`ID_Pagos`),
  ADD KEY `ID_Ususario` (`ID_Ususario`),
  ADD KEY `pagos_ibfk_2` (`ID_TipoEnvio`);

--
-- Indices de la tabla `maestrorevision`
--
ALTER TABLE `maestrorevision`
  ADD PRIMARY KEY (`IdRevision`);

--
-- Indices de la tabla `persona`
--
ALTER TABLE `persona`
  ADD PRIMARY KEY (`ID_Usuario`),
  ADD UNIQUE KEY `Documento` (`Documento`),
  ADD KEY `persona_ibfk_1` (`ID_Cuenta_Persona`);

--
-- Indices de la tabla `precio`
--
ALTER TABLE `precio`
  ADD PRIMARY KEY (`ID_Precio`);

--
-- Indices de la tabla `provincia`
--
ALTER TABLE `provincia`
  ADD PRIMARY KEY (`ID_Provincia`);

--
-- Indices de la tabla `tipo_envio`
--
ALTER TABLE `tipo_envio`
  ADD PRIMARY KEY (`ID_TipoEnvio`);

--
-- Indices de la tabla `tipo_vehiculo`
--
ALTER TABLE `tipo_vehiculo`
  ADD PRIMARY KEY (`ID_Tipo`);

--
-- Indices de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD PRIMARY KEY (`ID_Vehiculo`),
  ADD UNIQUE KEY `Num_Placa` (`Num_Placa`),
  ADD UNIQUE KEY `Num_Serie` (`Num_Serie`),
  ADD UNIQUE KEY `Num_Vin` (`Num_Vin`),
  ADD UNIQUE KEY `Num_Motor` (`Num_Motor`),
  ADD KEY `ID_Tipo` (`ID_Tipo`),
  ADD KEY `ID_Chofer` (`ID_Chofer`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `chofer`
--
ALTER TABLE `chofer`
  MODIFY `ID_Chofer` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `comprador`
--
ALTER TABLE `comprador`
  MODIFY `ID_Comprador` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  MODIFY `ID_Cuenta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `cuenta_empresa`
--
ALTER TABLE `cuenta_empresa`
  MODIFY `ID_Empresa` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `cuenta_persona`
--
ALTER TABLE `cuenta_persona`
  MODIFY `ID_Cuenta_Persona` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `destino`
--
ALTER TABLE `destino`
  MODIFY `ID_Destino` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `distrito`
--
ALTER TABLE `distrito`
  MODIFY `ID_Distrito` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT de la tabla `entrega`
--
ALTER TABLE `entrega`
  MODIFY `ID_Entrega` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `estado`
--
ALTER TABLE `estado`
  MODIFY `ID_Estado` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `estado_conductor`
--
ALTER TABLE `estado_conductor`
  MODIFY `ID_Estado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `ficha`
--
ALTER TABLE `ficha`
  MODIFY `ID_Ficha` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `items_reparto`
--
ALTER TABLE `items_reparto`
  MODIFY `ID_Items_Reparto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `maestroacceso`
--
ALTER TABLE `maestroacceso`
  MODIFY `IdAcceso` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestrobreved`
--
ALTER TABLE `maestrobreved`
  MODIFY `IdBreved` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestrocategoria`
--
ALTER TABLE `maestrocategoria`
  MODIFY `IdCategoria` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestrofactura`
--
ALTER TABLE `maestrofactura`
  MODIFY `Idcobros` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestropago`
--
ALTER TABLE `maestropago`
  MODIFY `ID_Pagos` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `maestrorevision`
--
ALTER TABLE `maestrorevision`
  MODIFY `IdRevision` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `persona`
--
ALTER TABLE `persona`
  MODIFY `ID_Usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `precio`
--
ALTER TABLE `precio`
  MODIFY `ID_Precio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `provincia`
--
ALTER TABLE `provincia`
  MODIFY `ID_Provincia` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_envio`
--
ALTER TABLE `tipo_envio`
  MODIFY `ID_TipoEnvio` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tipo_vehiculo`
--
ALTER TABLE `tipo_vehiculo`
  MODIFY `ID_Tipo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  MODIFY `ID_Vehiculo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `chofer`
--
ALTER TABLE `chofer`
  ADD CONSTRAINT `chofer_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `persona` (`ID_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cuenta_bancaria`
--
ALTER TABLE `cuenta_bancaria`
  ADD CONSTRAINT `cuenta_bancaria_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `persona` (`ID_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `destino`
--
ALTER TABLE `destino`
  ADD CONSTRAINT `destino_ibfk_1` FOREIGN KEY (`ID_Distrito`) REFERENCES `distrito` (`ID_Distrito`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `distrito`
--
ALTER TABLE `distrito`
  ADD CONSTRAINT `distrito_ibfk_1` FOREIGN KEY (`ID_Provincia`) REFERENCES `provincia` (`ID_Provincia`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `entrega`
--
ALTER TABLE `entrega`
  ADD CONSTRAINT `entrega_ibfk_1` FOREIGN KEY (`ID_Vehiculo`) REFERENCES `vehiculo` (`ID_Vehiculo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `entrega_ibfk_2` FOREIGN KEY (`ID_Ficha`) REFERENCES `ficha` (`ID_Ficha`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `estado_conductor`
--
ALTER TABLE `estado_conductor`
  ADD CONSTRAINT `estado_conductor_ibfk_1` FOREIGN KEY (`ID_Usuario`) REFERENCES `persona` (`ID_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `ficha`
--
ALTER TABLE `ficha`
  ADD CONSTRAINT `ficha_ibfk_3` FOREIGN KEY (`ID_TipoEnvio`) REFERENCES `tipo_envio` (`ID_TipoEnvio`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ficha_ibfk_5` FOREIGN KEY (`ID_Empresa`) REFERENCES `cuenta_empresa` (`ID_Empresa`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ficha_ibfk_6` FOREIGN KEY (`ID_Items_Reparto`) REFERENCES `items_reparto` (`ID_Items_Reparto`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ficha_ibfk_7` FOREIGN KEY (`ID_Comprador`) REFERENCES `comprador` (`ID_Comprador`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ficha_ibfk_8` FOREIGN KEY (`ID_Destino`) REFERENCES `destino` (`ID_Destino`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `items_reparto`
--
ALTER TABLE `items_reparto`
  ADD CONSTRAINT `items_reparto_ibfk_1` FOREIGN KEY (`ID_Precio`) REFERENCES `precio` (`ID_Precio`) ON DELETE CASCADE ON UPDATE NO ACTION;

--
-- Filtros para la tabla `maestroacceso`
--
ALTER TABLE `maestroacceso`
  ADD CONSTRAINT `maestroacceso_ibfk_1` FOREIGN KEY (`IdConductor`) REFERENCES `cuenta_persona` (`ID_Cuenta_Persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `maestrobreved`
--
ALTER TABLE `maestrobreved`
  ADD CONSTRAINT `maestrobreved_ibfk_1` FOREIGN KEY (`IdCategoria`) REFERENCES `maestrocategoria` (`IdCategoria`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maestrobreved_ibfk_2` FOREIGN KEY (`IdRevision`) REFERENCES `maestrorevision` (`IdRevision`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maestrobreved_ibfk_3` FOREIGN KEY (`IdCond`) REFERENCES `persona` (`ID_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `maestrofactura`
--
ALTER TABLE `maestrofactura`
  ADD CONSTRAINT `maestrofactura_ibfk_1` FOREIGN KEY (`IdEmpresa`) REFERENCES `cuenta_empresa` (`ID_Empresa`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `maestropago`
--
ALTER TABLE `maestropago`
  ADD CONSTRAINT `maestropago_ibfk_1` FOREIGN KEY (`ID_Ususario`) REFERENCES `persona` (`ID_Usuario`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `maestropago_ibfk_2` FOREIGN KEY (`ID_TipoEnvio`) REFERENCES `tipo_envio` (`ID_TipoEnvio`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `persona`
--
ALTER TABLE `persona`
  ADD CONSTRAINT `persona_ibfk_1` FOREIGN KEY (`ID_Cuenta_Persona`) REFERENCES `cuenta_persona` (`ID_Cuenta_Persona`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `vehiculo`
--
ALTER TABLE `vehiculo`
  ADD CONSTRAINT `vehiculo_ibfk_1` FOREIGN KEY (`ID_Tipo`) REFERENCES `tipo_vehiculo` (`ID_Tipo`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `vehiculo_ibfk_2` FOREIGN KEY (`ID_Chofer`) REFERENCES `chofer` (`ID_Chofer`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
