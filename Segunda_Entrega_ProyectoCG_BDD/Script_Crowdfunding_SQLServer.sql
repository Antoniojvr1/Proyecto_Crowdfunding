
-- =============================================================================
USE CrowdfundingDB;
GO

-- =====================================================
-- 2. ELIMINACIÓN DE OBJETOS EXISTENTES (PARA REEJECUCIÓN)
-- =====================================================
-- Eliminar vistas primero
IF OBJECT_ID('vw_LandingPage', 'V') IS NOT NULL DROP VIEW vw_LandingPage;
IF OBJECT_ID('vw_Actividades', 'V') IS NOT NULL DROP VIEW vw_Actividades;
IF OBJECT_ID('vw_Donaciones', 'V') IS NOT NULL DROP VIEW vw_Donaciones;
IF OBJECT_ID('vw_Noticias', 'V') IS NOT NULL DROP VIEW vw_Noticias;
IF OBJECT_ID('vw_Reportes', 'V') IS NOT NULL DROP VIEW vw_Reportes;
IF OBJECT_ID('vw_Foro', 'V') IS NOT NULL DROP VIEW vw_Foro;
IF OBJECT_ID('vw_Usuarios', 'V') IS NOT NULL DROP VIEW vw_Usuarios;
IF OBJECT_ID('vw_PreguntasFrecuentes', 'V') IS NOT NULL DROP VIEW vw_PreguntasFrecuentes;
IF OBJECT_ID('vw_EstadisticasProyectos', 'V') IS NOT NULL DROP VIEW vw_EstadisticasProyectos;
IF OBJECT_ID('vw_Recompensas', 'V') IS NOT NULL DROP VIEW vw_Recompensas;
IF OBJECT_ID('vw_HistorialDonaciones', 'V') IS NOT NULL DROP VIEW vw_HistorialDonaciones;
IF OBJECT_ID('vw_ActividadesPopulares', 'V') IS NOT NULL DROP VIEW vw_ActividadesPopulares;
GO

-- Eliminar tablas en orden inverso (para respetar FK)
IF OBJECT_ID('Mensajeria', 'U') IS NOT NULL DROP TABLE Mensajeria;
IF OBJECT_ID('Conversacion', 'U') IS NOT NULL DROP TABLE Conversacion;
IF OBJECT_ID('Notificacion', 'U') IS NOT NULL DROP TABLE Notificacion;
IF OBJECT_ID('Mensaje', 'U') IS NOT NULL DROP TABLE Mensaje;
IF OBJECT_ID('Sancion', 'U') IS NOT NULL DROP TABLE Sancion;
IF OBJECT_ID('Historial_Actividades', 'U') IS NOT NULL DROP TABLE Historial_Actividades;
IF OBJECT_ID('Certificado', 'U') IS NOT NULL DROP TABLE Certificado;
IF OBJECT_ID('Recompensa', 'U') IS NOT NULL DROP TABLE Recompensa;
IF OBJECT_ID('Capacitacion', 'U') IS NOT NULL DROP TABLE Capacitacion;
IF OBJECT_ID('Foro', 'U') IS NOT NULL DROP TABLE Foro;
IF OBJECT_ID('Presupuesto', 'U') IS NOT NULL DROP TABLE Presupuesto;
IF OBJECT_ID('preguntas_Frecuentes', 'U') IS NOT NULL DROP TABLE preguntas_Frecuentes;
IF OBJECT_ID('MetaActividad', 'U') IS NOT NULL DROP TABLE MetaActividad;
IF OBJECT_ID('Documentacion', 'U') IS NOT NULL DROP TABLE Documentacion;
IF OBJECT_ID('Marketing', 'U') IS NOT NULL DROP TABLE Marketing;
IF OBJECT_ID('Noticia', 'U') IS NOT NULL DROP TABLE Noticia;
IF OBJECT_ID('reembolso', 'U') IS NOT NULL DROP TABLE reembolso;
IF OBJECT_ID('DetalleComprobante', 'U') IS NOT NULL DROP TABLE DetalleComprobante;
IF OBJECT_ID('Movimiento', 'U') IS NOT NULL DROP TABLE Movimiento;
IF OBJECT_ID('Comprobante', 'U') IS NOT NULL DROP TABLE Comprobante;
IF OBJECT_ID('Forma_Pago', 'U') IS NOT NULL DROP TABLE Forma_Pago;
IF OBJECT_ID('Pago', 'U') IS NOT NULL DROP TABLE Pago;
IF OBJECT_ID('Reseña', 'U') IS NOT NULL DROP TABLE Reseña;
IF OBJECT_ID('Reporte', 'U') IS NOT NULL DROP TABLE Reporte;
IF OBJECT_ID('Beneficiario', 'U') IS NOT NULL DROP TABLE Beneficiario;
IF OBJECT_ID('Donacion', 'U') IS NOT NULL DROP TABLE Donacion;
IF OBJECT_ID('Donante', 'U') IS NOT NULL DROP TABLE Donante;
IF OBJECT_ID('Proyecto', 'U') IS NOT NULL DROP TABLE Proyecto;
IF OBJECT_ID('Actividad', 'U') IS NOT NULL DROP TABLE Actividad;
IF OBJECT_ID('Tipo_Actividad', 'U') IS NOT NULL DROP TABLE Tipo_Actividad;
IF OBJECT_ID('Telefono', 'U') IS NOT NULL DROP TABLE Telefono;
IF OBJECT_ID('Administrador', 'U') IS NOT NULL DROP TABLE Administrador;
IF OBJECT_ID('Creador', 'U') IS NOT NULL DROP TABLE Creador;
IF OBJECT_ID('usuario', 'U') IS NOT NULL DROP TABLE usuario;
IF OBJECT_ID('Patrocinador', 'U') IS NOT NULL DROP TABLE Patrocinador;
IF OBJECT_ID('TipoRecompensa', 'U') IS NOT NULL DROP TABLE TipoRecompensa;
GO

-- =====================================================
-- 3. CREACIÓN DE TABLAS CATÁLOGO (Tablas Maestras)
-- =====================================================
-- NOTA: Las tablas catálogo contienen datos de referencia
-- que cambian poco frecuentemente (generalmente configuraciones,
-- tipos, categorías, etc.)

-- Catálogo: Tipos de Actividad
CREATE TABLE Tipo_Actividad (
    idTipo_Actividad INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(45) NULL,
    descripcion VARCHAR(200) NULL,
    CONSTRAINT PK_Tipo_Actividad PRIMARY KEY (idTipo_Actividad)
);
GO

-- Catálogo: Formas de Pago
CREATE TABLE Forma_Pago (
    idForma_Pago INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(45) NULL,
    descripcion VARCHAR(200) NULL,
    CONSTRAINT PK_Forma_Pago PRIMARY KEY (idForma_Pago)
);
GO

-- Catálogo: Comprobantes (Tipos de comprobante)
CREATE TABLE Comprobante (
    idComprobante INT IDENTITY(1,1) NOT NULL,
    descripcion VARCHAR(100) NULL,
    CONSTRAINT PK_Comprobante PRIMARY KEY (idComprobante)
);
GO

-- Catálogo: Tipos de Recompensa
CREATE TABLE TipoRecompensa (
    idTipoRecompensa INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(45) NULL,
    descripcion VARCHAR(200) NULL,
    CONSTRAINT PK_TipoRecompensa PRIMARY KEY (idTipoRecompensa)
);
GO

-- Catálogo: Patrocinadores
CREATE TABLE Patrocinador (
    idPatrocinador INT IDENTITY(1,1) NOT NULL,
    nom_patro VARCHAR(100) NULL,
    contacto VARCHAR(45) NULL,
    correo VARCHAR(100) NULL,
    direccion VARCHAR(100) NULL,
    CONSTRAINT PK_Patrocinador PRIMARY KEY (idPatrocinador)
);
GO

-- =====================================================
-- 4. CREACIÓN DE TABLAS TRANSACCIONALES
-- =====================================================
-- NOTA: Las tablas transaccionales registran operaciones
-- del sistema y generalmente tienen muchos registros

-- Tabla: Usuarios
CREATE TABLE usuario (
    idUsuario INT IDENTITY(1,1) NOT NULL,
    Pnom VARCHAR(45) NULL,
    Snom VARCHAR(45) NULL,
    Pappe VARCHAR(45) NULL,
    Sappe VARCHAR(45) NULL,
    correo VARCHAR(100) NULL,
    direccion VARCHAR(100) NULL,
    userName VARCHAR(45) NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_usuario PRIMARY KEY (idUsuario)
);
GO

-- Tabla: Creadores
CREATE TABLE Creador (
    idCreador INT IDENTITY(1,1) NOT NULL,
    nom_creador VARCHAR(100) NULL,
    estado VARCHAR(20) DEFAULT 'Activo',
    Usuario_idUsuario INT NOT NULL,
    CONSTRAINT PK_Creador PRIMARY KEY (idCreador),
    CONSTRAINT FK_Creador_usuario FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Administradores
CREATE TABLE Administrador (
    idAdministrador INT IDENTITY(1,1) NOT NULL,
    niv_acceso VARCHAR(45) NULL,
    departamento VARCHAR(45) NULL,
    Usuario_idUsuario INT NOT NULL,
    CONSTRAINT PK_Administrador PRIMARY KEY (idAdministrador),
    CONSTRAINT FK_Administrador_usuario FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Teléfonos
CREATE TABLE Telefono (
    idTelefono INT IDENTITY(1,1) NOT NULL,
    num_telefono VARCHAR(20) NULL,
    Usuario_idUsuario INT NOT NULL,
    CONSTRAINT PK_Telefono PRIMARY KEY (idTelefono),
    CONSTRAINT FK_Telefono_usuario FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Actividades
CREATE TABLE Actividad (
    idActividad INT IDENTITY(1,1) NOT NULL,
    nom_actividad VARCHAR(100) NULL,
    fecha_inicio DATE NULL,
    fecha_fin DATE NULL,
    meta VARCHAR(100) NULL,
    Patrocinador_idPatrocinador INT NOT NULL,
    Tipo_Actividad_idTipo_Actividad INT NOT NULL,
    CONSTRAINT PK_Actividad PRIMARY KEY (idActividad),
    CONSTRAINT FK_Actividad_Patrocinador FOREIGN KEY (Patrocinador_idPatrocinador) 
        REFERENCES Patrocinador(idPatrocinador),
    CONSTRAINT FK_Actividad_Tipo_Actividad FOREIGN KEY (Tipo_Actividad_idTipo_Actividad) 
        REFERENCES Tipo_Actividad(idTipo_Actividad)
);
GO

-- Tabla: Donantes
CREATE TABLE Donante (
    idDonante INT IDENTITY(1,1) NOT NULL,
    fecha_donacion DATE NULL,
    tipo_donacion VARCHAR(45) NULL,
    estado_Donacion VARCHAR(45) DEFAULT 'Activa',
    usuario_idUsuario INT NOT NULL,
    CONSTRAINT PK_Donante PRIMARY KEY (idDonante),
    CONSTRAINT FK_Donante_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Proyectos
CREATE TABLE Proyecto (
    idProyecto INT IDENTITY(1,1) NOT NULL,
    nombre_Proyecto VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    fecha_Inicio DATE NULL,
    fecha_Fin DATE NULL,
    estado VARCHAR(20) DEFAULT 'Activo',
    Creador_idCreador INT NOT NULL,
    CONSTRAINT PK_Proyecto PRIMARY KEY (idProyecto),
    CONSTRAINT FK_Proyecto_Creador FOREIGN KEY (Creador_idCreador) 
        REFERENCES Creador(idCreador)
);
GO

-- Tabla: Donaciones
CREATE TABLE Donacion (
    idDonacion INT IDENTITY(1,1) NOT NULL,
    monto DECIMAL(18,2) NOT NULL,
    anonima VARCHAR(2) DEFAULT 'NO',
    mensaje VARCHAR(500) NULL,
    fecha DATE DEFAULT GETDATE(),
    Usuario_idUsuario INT NOT NULL,
    Donante_idDonante INT NOT NULL,
    Proyecto_idProyecto INT NOT NULL,
    CONSTRAINT PK_Donacion PRIMARY KEY (idDonacion),
    CONSTRAINT FK_Donacion_usuario FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES usuario(idUsuario),
    CONSTRAINT FK_Donacion_Donante FOREIGN KEY (Donante_idDonante) 
        REFERENCES Donante(idDonante),
    CONSTRAINT FK_Donacion_Proyecto FOREIGN KEY (Proyecto_idProyecto) 
        REFERENCES Proyecto(idProyecto)
);
GO

-- Tabla: Beneficiarios
CREATE TABLE Beneficiario (
    idBeneficiario INT IDENTITY(1,1) NOT NULL,
    nom VARCHAR(100) NULL,
    contacto VARCHAR(45) NULL,
    descripcion TEXT NULL,
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Beneficiario PRIMARY KEY (idBeneficiario),
    CONSTRAINT FK_Beneficiario_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Pagos
CREATE TABLE Pago (
    idPago INT IDENTITY(1,1) NOT NULL,
    monto DECIMAL(18,2) NULL,
    fecha DATE DEFAULT GETDATE(),
    estado VARCHAR(45) DEFAULT 'Pendiente',
    referencia VARCHAR(45) NULL,
    Donacion_idDonacion INT NOT NULL,
    CONSTRAINT PK_Pago PRIMARY KEY (idPago),
    CONSTRAINT FK_Pago_Donacion FOREIGN KEY (Donacion_idDonacion) 
        REFERENCES Donacion(idDonacion)
);
GO

-- Tabla: Reportes
CREATE TABLE Reporte (
    idReporte INT IDENTITY(1,1) NOT NULL,
    mensaje VARCHAR(200) NULL,
    fecha DATE DEFAULT GETDATE(),
    motivo VARCHAR(100) NULL,
    estado VARCHAR(45) DEFAULT 'Pendiente',
    descripcion TEXT NULL,
    Usuario_idUsuario INT NOT NULL,
    Administrador_idAdministrador INT NOT NULL,
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Reporte PRIMARY KEY (idReporte),
    CONSTRAINT FK_Reporte_usuario FOREIGN KEY (Usuario_idUsuario) 
        REFERENCES usuario(idUsuario),
    CONSTRAINT FK_Reporte_Administrador FOREIGN KEY (Administrador_idAdministrador) 
        REFERENCES Administrador(idAdministrador),
    CONSTRAINT FK_Reporte_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Reseñas
CREATE TABLE Reseña (
    idReseña INT IDENTITY(1,1) NOT NULL,
    descripcion VARCHAR(500) NULL,
    usuario_idUsuario INT NOT NULL,
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Reseña PRIMARY KEY (idReseña),
    CONSTRAINT FK_Reseña_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario),
    CONSTRAINT FK_Reseña_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Movimientos
CREATE TABLE Movimiento (
    Pago_idPago INT NOT NULL,
    Forma_Pago_idForma_Pago INT NOT NULL,
    monto DECIMAL(18,2) NULL,
    CONSTRAINT PK_Movimiento PRIMARY KEY (Pago_idPago, Forma_Pago_idForma_Pago),
    CONSTRAINT FK_Movimiento_Pago FOREIGN KEY (Pago_idPago) 
        REFERENCES Pago(idPago),
    CONSTRAINT FK_Movimiento_Forma_Pago FOREIGN KEY (Forma_Pago_idForma_Pago) 
        REFERENCES Forma_Pago(idForma_Pago)
);
GO

-- Tabla: Detalle de Comprobantes
CREATE TABLE DetalleComprobante (
    Movimiento_Pago_idPago INT NOT NULL,
    Movimiento_Forma_Pago_idForma_Pago INT NOT NULL,
    Factura_idFactura INT NOT NULL,
    usuario_idUsuario INT NOT NULL,
    Monto DECIMAL(18,2) NULL,
    Estado VARCHAR(45) NULL,
    CONSTRAINT PK_DetalleComprobante PRIMARY KEY (Movimiento_Pago_idPago, Movimiento_Forma_Pago_idForma_Pago, Factura_idFactura),
    CONSTRAINT FK_DetalleComprobante_Movimiento FOREIGN KEY (Movimiento_Pago_idPago, Movimiento_Forma_Pago_idForma_Pago) 
        REFERENCES Movimiento(Pago_idPago, Forma_Pago_idForma_Pago),
    CONSTRAINT FK_DetalleComprobante_Factura FOREIGN KEY (Factura_idFactura) 
        REFERENCES Comprobante(idComprobante),
    CONSTRAINT FK_DetalleComprobante_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Reembolsos
CREATE TABLE reembolso (
    idreembolso INT IDENTITY(1,1) NOT NULL,
    fecha DATETIME DEFAULT GETDATE(),
    motivo VARCHAR(100) NULL,
    descripcion VARCHAR(200) NULL,
    Pago_idPago INT NOT NULL,
    CONSTRAINT PK_reembolso PRIMARY KEY (idreembolso),
    CONSTRAINT FK_reembolso_Pago FOREIGN KEY (Pago_idPago) 
        REFERENCES Pago(idPago)
);
GO

-- Tabla: Noticias
CREATE TABLE Noticia (
    idNoticia INT IDENTITY(1,1) NOT NULL,
    titulo VARCHAR(200) NULL,
    contenido TEXT NULL,
    fechaPublicacion DATE DEFAULT GETDATE(),
    Administrador_idAdministrador INT NOT NULL,
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Noticia PRIMARY KEY (idNoticia),
    CONSTRAINT FK_Noticia_Administrador FOREIGN KEY (Administrador_idAdministrador) 
        REFERENCES Administrador(idAdministrador),
    CONSTRAINT FK_Noticia_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Marketing
CREATE TABLE Marketing (
    idMarketing INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    fechaInicio DATE NOT NULL,
    fechaFin DATE NOT NULL,
    Administrador_idAdministrador INT NOT NULL,
    Proyecto_idProyecto INT NOT NULL,
    CONSTRAINT PK_Marketing PRIMARY KEY (idMarketing),
    CONSTRAINT FK_Marketing_Administrador FOREIGN KEY (Administrador_idAdministrador) 
        REFERENCES Administrador(idAdministrador),
    CONSTRAINT FK_Marketing_Proyecto FOREIGN KEY (Proyecto_idProyecto) 
        REFERENCES Proyecto(idProyecto)
);
GO

-- Tabla: Documentación
CREATE TABLE Documentacion (
    idDocumentacion INT IDENTITY(1,1) NOT NULL,
    nombreArchivo VARCHAR(100) NULL,
    tipoArchivo VARCHAR(45) NULL,
    url VARCHAR(200) NULL,
    fecha DATE DEFAULT GETDATE(),
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Documentacion PRIMARY KEY (idDocumentacion),
    CONSTRAINT FK_Documentacion_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Metas de Actividad
CREATE TABLE MetaActividad (
    idMetaActividad INT IDENTITY(1,1) NOT NULL,
    descripcion VARCHAR(200) NULL,
    fechaRealizacion DATE NULL,
    monto_meta DECIMAL(18,2) NULL,
    monto_actual DECIMAL(18,2) DEFAULT 0,
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_MetaActividad PRIMARY KEY (idMetaActividad),
    CONSTRAINT FK_MetaActividad_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Preguntas Frecuentes
CREATE TABLE preguntas_Frecuentes (
    idpreguntas_Frecuentes INT IDENTITY(1,1) NOT NULL,
    pregunta VARCHAR(500) NULL,
    respuesta VARCHAR(1000) NULL,
    categoria VARCHAR(50) NULL,
    fecha_creacion DATE DEFAULT GETDATE(),
    Actividad_idActividad INT NULL,
    CONSTRAINT PK_preguntas_Frecuentes PRIMARY KEY (idpreguntas_Frecuentes),
    CONSTRAINT FK_preguntas_Frecuentes_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Presupuesto
CREATE TABLE Presupuesto (
    idPresupuesto INT IDENTITY(1,1) NOT NULL,
    descripcion_gastos VARCHAR(200) NULL,
    monto_Estimado DECIMAL(18,2) NULL,
    monto_Real DECIMAL(18,2) NULL,
    Proyecto_idProyecto INT NOT NULL,
    CONSTRAINT PK_Presupuesto PRIMARY KEY (idPresupuesto),
    CONSTRAINT FK_Presupuesto_Proyecto FOREIGN KEY (Proyecto_idProyecto) 
        REFERENCES Proyecto(idProyecto)
);
GO

-- Tabla: Foro
CREATE TABLE Foro (
    idForo INT IDENTITY(1,1) NOT NULL,
    nombreForo VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    fecha_creacion DATE DEFAULT GETDATE(),
    Actividad_idActividad INT NOT NULL,
    CONSTRAINT PK_Foro PRIMARY KEY (idForo),
    CONSTRAINT FK_Foro_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Capacitación
CREATE TABLE Capacitacion (
    idCapacitacion INT IDENTITY(1,1) NOT NULL,
    titulo_Capacitacion VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    fecha_inicio DATE NULL,
    fecha_fin DATE NULL,
    usuario_idUsuario INT NOT NULL,
    Administrador_idAdministrador INT NOT NULL,
    CONSTRAINT PK_Capacitacion PRIMARY KEY (idCapacitacion),
    CONSTRAINT FK_Capacitacion_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario),
    CONSTRAINT FK_Capacitacion_Administrador FOREIGN KEY (Administrador_idAdministrador) 
        REFERENCES Administrador(idAdministrador)
);
GO

-- Tabla: Recompensas
CREATE TABLE Recompensa (
    idrecompensa INT IDENTITY(1,1) NOT NULL,
    nombre VARCHAR(100) NULL,
    descripcion VARCHAR(500) NULL,
    monto_minimo DECIMAL(18,2) NULL,
    fecha_Entrega DATE NULL,
    TipoRecompensa_idTipoRecompensa INT NOT NULL,
    Proyecto_idProyecto INT NOT NULL,
    CONSTRAINT PK_Recompensa PRIMARY KEY (idrecompensa),
    CONSTRAINT FK_Recompensa_TipoRecompensa FOREIGN KEY (TipoRecompensa_idTipoRecompensa) 
        REFERENCES TipoRecompensa(idTipoRecompensa),
    CONSTRAINT FK_Recompensa_Proyecto FOREIGN KEY (Proyecto_idProyecto) 
        REFERENCES Proyecto(idProyecto)
);
GO

-- Tabla: Certificados
CREATE TABLE Certificado (
    idCertificado INT IDENTITY(1,1) NOT NULL,
    tipo_certificado VARCHAR(45) NULL,
    fecha_entrega DATE NULL,
    Proyecto_idProyecto INT NOT NULL,
    CONSTRAINT PK_Certificado PRIMARY KEY (idCertificado),
    CONSTRAINT FK_Certificado_Proyecto FOREIGN KEY (Proyecto_idProyecto) 
        REFERENCES Proyecto(idProyecto)
);
GO

-- Tabla: Historial de Actividades
CREATE TABLE Historial_Actividades (
    Creador_idCreador INT NOT NULL,
    Actividad_idActividad INT NOT NULL,
    fecha_inicio DATE NULL,
    fecha_fin DATE NULL,
    descripcion VARCHAR(200) NULL,
    CONSTRAINT PK_Historial_Actividades PRIMARY KEY (Creador_idCreador, Actividad_idActividad),
    CONSTRAINT FK_Historial_Creador FOREIGN KEY (Creador_idCreador) 
        REFERENCES Creador(idCreador),
    CONSTRAINT FK_Historial_Actividad FOREIGN KEY (Actividad_idActividad) 
        REFERENCES Actividad(idActividad)
);
GO

-- Tabla: Sanciones
CREATE TABLE Sancion (
    idSancion INT IDENTITY(1,1) NOT NULL,
    motivo VARCHAR(200) NULL,
    fecha_sancion DATE DEFAULT GETDATE(),
    tipo_sancion VARCHAR(50) NULL,
    Administrador_idAdministrador INT NOT NULL,
    CONSTRAINT PK_Sancion PRIMARY KEY (idSancion),
    CONSTRAINT FK_Sancion_Administrador FOREIGN KEY (Administrador_idAdministrador) 
        REFERENCES Administrador(idAdministrador)
);
GO

-- Tabla: Mensajes
CREATE TABLE Mensaje (
    idMensaje INT IDENTITY(1,1) NOT NULL,
    ContenidoMensaje VARCHAR(500) NULL,
    usuario_idUsuario INT NOT NULL,
    fecha_envio DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Mensaje PRIMARY KEY (idMensaje),
    CONSTRAINT FK_Mensaje_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

-- Tabla: Conversación
CREATE TABLE Conversacion (
    idConversacion INT IDENTITY(1,1) NOT NULL,
    fechaConversacion DATETIME DEFAULT GETDATE(),
    asunto VARCHAR(200) NULL,
    CONSTRAINT PK_Conversacion PRIMARY KEY (idConversacion)
);
GO

-- Tabla: Mensajería (relación entre Mensaje y Conversación)
CREATE TABLE Mensajeria (
    Mensaje_idMensaje INT NOT NULL,
    Conversacion_idConversacion INT NOT NULL,
    Estado VARCHAR(45) DEFAULT 'Enviado',
    fecha_recepcion DATETIME NULL,
    CONSTRAINT PK_Mensajeria PRIMARY KEY (Mensaje_idMensaje, Conversacion_idConversacion),
    CONSTRAINT FK_Mensajeria_Mensaje FOREIGN KEY (Mensaje_idMensaje) 
        REFERENCES Mensaje(idMensaje),
    CONSTRAINT FK_Mensajeria_Conversacion FOREIGN KEY (Conversacion_idConversacion) 
        REFERENCES Conversacion(idConversacion)
);
GO

-- Tabla: Notificaciones
CREATE TABLE Notificacion (
    idNotificacion INT IDENTITY(1,1) NOT NULL,
    usuario_idUsuario INT NOT NULL,
    descripcion VARCHAR(200) NULL,
    titulo VARCHAR(100) NULL,
    referencia VARCHAR(100) NULL,
    fecha_envio DATETIME DEFAULT GETDATE(),
    leida BIT DEFAULT 0,
    CONSTRAINT PK_Notificacion PRIMARY KEY (idNotificacion),
    CONSTRAINT FK_Notificacion_usuario FOREIGN KEY (usuario_idUsuario) 
        REFERENCES usuario(idUsuario)
);
GO

PRINT 'Tablas creadas exitosamente.';
GO

-- =====================================================
-- 5. INSERTS DE DATOS DE PRUEBA
-- =====================================================

-- -----------------------------------------------------
-- CATÁLOGOS (Mínimo 15 registros cada uno)
-- -----------------------------------------------------

-- Insertar Tipo_Actividad (15 registros)
INSERT INTO Tipo_Actividad (nom, descripcion) VALUES
('Recaudación de Fondos', 'Actividades para recolectar donaciones monetarias'),
('Evento Benéfico', 'Eventos organizados para causas sociales'),
('Campaña de Concienciación', 'Campañas para crear conciencia sobre temas importantes'),
('Subasta', 'Subastas de artículos para recaudar fondos'),
('Maratón', 'Carreras o caminatas para recaudación de fondos'),
('Concierto Benéfico', 'Eventos musicales con fines solidarios'),
('Cena de Gala', 'Eventos formales para recaudación de fondos'),
('Venta de Productos', 'Venta de artículos para apoyar causas'),
('Voluntariado', 'Actividades de voluntariado comunitario'),
('Crowdfunding', 'Campañas de financiamiento colectivo'),
('Donación de Sangre', 'Campañas para donación de sangre'),
('Recolección de Alimentos', 'Campañas para recolectar alimentos'),
('Adopción de Mascotas', 'Eventos para promover adopción de animales'),
('Reforestación', 'Actividades de plantación de árboles'),
('Taller Educativo', 'Talleres con fines educativos y benéficos');
GO

-- Insertar Forma_Pago (15 registros)
INSERT INTO Forma_Pago (nom, descripcion) VALUES
('Tarjeta de Crédito', 'Pago con tarjeta de crédito Visa, Mastercard, etc.'),
('Tarjeta de Débito', 'Pago directo desde cuenta bancaria'),
('PayPal', 'Pago a través de la plataforma PayPal'),
('Transferencia Bancaria', 'Transferencia directa entre cuentas bancarias'),
('Depósito Bancario', 'Depósito en ventanilla o cajero automático'),
('Efectivo', 'Pago en efectivo en puntos autorizados'),
('Criptomonedas', 'Pago con Bitcoin, Ethereum u otras criptomonedas'),
('Apple Pay', 'Pago mediante la billetera digital de Apple'),
('Google Pay', 'Pago mediante la billetera digital de Google'),
('Mercado Pago', 'Pago a través de la plataforma Mercado Pago'),
('Stripe', 'Pago procesado mediante Stripe'),
('Square', 'Pago procesado mediante Square'),
('Zelle', 'Transferencia rápida entre bancos'),
('Venmo', 'Pago entre personas mediante Venmo'),
('Cheque', 'Pago mediante cheque bancario');
GO

-- Insertar Comprobante (15 registros)
INSERT INTO Comprobante (descripcion) VALUES
('Factura Electrónica'),
('Factura Física'),
('Recibo Simple'),
('Comprobante de Donación'),
('Certificado de Aporte'),
('Nota de Crédito'),
('Nota de Débito'),
('Boleta de Venta'),
('Comprobante de Retención'),
('Liquidación de Compra'),
('Guía de Remisión'),
('Comprobante de Pago'),
('Constancia de Donación'),
('Recibo Oficial'),
('Comprobante Tributario');
GO

-- Insertar TipoRecompensa (15 registros)
INSERT INTO TipoRecompensa (nombre, descripcion) VALUES
('Agradecimiento Digital', 'Agradecimiento por correo electrónico o redes sociales'),
('Mención Especial', 'Mención en la página del proyecto'),
('Producto Físico', 'Envío de producto relacionado con el proyecto'),
('Experiencia Exclusiva', 'Invitación a eventos exclusivos'),
('Reconocimiento Público', 'Reconocimiento en eventos públicos'),
('Descuento en Productos', 'Cupones de descuento para futuras compras'),
('Acceso Anticipado', 'Acceso temprano a productos o servicios'),
('Contenido Exclusivo', 'Acceso a contenido exclusivo del proyecto'),
('Merchandising', 'Artículos promocionales del proyecto'),
('Certificado Digital', 'Certificado de agradecimiento digital'),
('Videollamada', 'Sesión de videollamada con el equipo'),
('Taller Exclusivo', 'Acceso a talleres exclusivos'),
('Suscripción Gratuita', 'Suscripción gratuita a servicios'),
('Sorteo Especial', 'Participación en sorteos exclusivos'),
('Recompensa Personalizada', 'Recompensa adaptada al donante');
GO

-- Insertar Patrocinador (15 registros)
INSERT INTO Patrocinador (nom_patro, contacto, correo, direccion) VALUES
('Fundación Esperanza', '+503 2222-1111', 'contacto@esperanza.org', 'Av. Principal #123, San Salvador'),
('Corporación Eléctrica S.A.', '+503 2222-2222', 'patrocinios@electricasa.com', 'Calle Industrial #45, Santa Ana'),
('Banco del Progreso', '+503 2222-3333', 'responsabilidad@bancoprogreso.com', 'Edificio Financiero, San Salvador'),
('Supermercados La Familia', '+503 2222-4444', 'marketing@lafamilia.com', 'Centro Comercial Metro, San Salvador'),
('Tecnología Avanzada S.A.', '+503 2222-5555', 'sponsor@tecnoadv.com', 'Zona Industrial, La Libertad'),
('Constructora del Futuro', '+503 2222-6666', 'comunicaciones@confuturo.com', 'Blvd. Los Próceres, San Salvador'),
('Farmacias Salud Total', '+503 2222-7777', 'rrss@saludtotal.com', 'Centro Médico Integral, San Miguel'),
('Automotriz Centroamericana', '+503 2222-8888', 'patrocinios@autocentro.com', 'Km. 5 Carretera al Puerto, La Libertad'),
('Telecomunicaciones Nacionales', '+503 2222-9999', 'fundacion@telcnal.com', 'Torre Telecom, San Salvador'),
('Energía Renovable S.A.', '+503 2222-0000', 'comunicacion@energiaren.com', 'Parque Eólico, Ahuachapán'),
('Café de El Salvador', '+503 2222-1212', 'export@cafeelsalvador.com', 'Finca Las Mercedes, Santa Ana'),
('Industrias Textiles Unidas', '+503 2222-2323', 'info@textilesunidos.com', 'Zona Francera, San Miguel'),
('Agroexportadora del Pacífico', '+503 2222-3434', 'ventas@agropacifico.com', 'Puerto de Acajutla, Sonsonate'),
('Hotel y Resorts del Sur', '+503 2222-4545', 'eventos@hotelsur.com', 'Playa El Tunco, La Libertad'),
('Universidad del Desarrollo', '+503 2222-5656', 'extension@udesarrollo.edu.sv', 'Campus Universitario, San Salvador');
GO

PRINT 'Catálogos insertados exitosamente.';
GO

-- -----------------------------------------------------
-- TABLAS TRANSACCIONALES (Mínimo 30 registros cada una)
-- -----------------------------------------------------

-- Insertar Usuarios (35 registros)
INSERT INTO usuario (Pnom, Snom, Pappe, Sappe, correo, direccion, userName, FechaRegistro) VALUES
('Juan', 'Carlos', 'Pérez', 'García', 'juan.perez@email.com', 'Colonia Escalón, San Salvador', 'jperez', '2024-01-15'),
('María', 'Elena', 'Rodríguez', 'López', 'maria.rodriguez@email.com', 'Santa Tecla, La Libertad', 'mrodriguez', '2024-01-16'),
('Pedro', 'Antonio', 'Martínez', 'Hernández', 'pedro.martinez@email.com', 'San Miguel, San Miguel', 'pmartinez', '2024-01-18'),
('Ana', 'Lucía', 'Gómez', 'Díaz', 'ana.gomez@email.com', 'Santa Ana, Santa Ana', 'agomez', '2024-01-20'),
('Luis', 'Fernando', 'Sánchez', 'Torres', 'luis.sanchez@email.com', 'Soyapango, San Salvador', 'lsanchez', '2024-01-22'),
('Carmen', 'Isabel', 'Flores', 'Morales', 'carmen.flores@email.com', 'Mejicanos, San Salvador', 'cflores', '2024-01-25'),
('Roberto', 'Alejandro', 'Vásquez', 'Castro', 'roberto.vasquez@email.com', 'Apopa, San Salvador', 'rvasquez', '2024-01-28'),
('Diana', 'Patricia', 'Reyes', 'Ortiz', 'diana.reyes@email.com', 'San Marcos, San Salvador', 'dreyes', '2024-02-01'),
('Miguel', 'Ángel', 'Jiménez', 'Ruiz', 'miguel.jimenez@email.com', 'Ilopango, San Salvador', 'mjimenez', '2024-02-05'),
('Laura', 'Fernanda', 'Mendoza', 'Silva', 'laura.mendoza@email.com', 'Antiguo Cuscatlán, La Libertad', 'lmendoza', '2024-02-08'),
('Francisco', 'Javier', 'Herrera', 'Ramos', 'francisco.herrera@email.com', 'Cojutepeque, Cuscatlán', 'fherrera', '2024-02-10'),
('Sofía', 'Alejandra', 'Aguilar', 'Chávez', 'sofia.aguilar@email.com', 'Zacatecoluca, La Paz', 'saguilar', '2024-02-12'),
('Diego', 'Armando', 'Moreno', 'Fuentes', 'diego.moreno@email.com', 'Ahuachapán, Ahuachapán', 'dmoreno', '2024-02-15'),
('Valentina', 'Cristina', 'Romero', 'Navarro', 'valentina.romero@email.com', 'Sonsonate, Sonsonate', 'vromero', '2024-02-18'),
('Andrés', 'Felipe', 'Ortega', 'Delgado', 'andres.ortega@email.com', 'La Unión, La Unión', 'aortega', '2024-02-20'),
('Gabriela', 'María', 'Castillo', 'Vargas', 'gabriela.castillo@email.com', 'Chalatenango, Chalatenango', 'gcastillo', '2024-02-22'),
('Daniel', 'Eduardo', 'Guerrero', 'Soto', 'daniel.guerrero@email.com', 'Metapán, Santa Ana', 'dguerrero', '2024-02-25'),
('Natalia', 'Fernanda', 'Medina', 'Cruz', 'natalia.medina@email.com', 'Usulután, Usulután', 'nmedina', '2024-02-28'),
('Eduardo', 'José', 'Rojas', 'Molina', 'eduardo.rojas@email.com', 'Sensuntepeque, Cabañas', 'erojas', '2024-03-01'),
('Isabella', 'Nicole', 'GuZMán', 'Ferrer', 'isabella.guzman@email.com', 'San Vicente, San Vicente', 'iguzman', '2024-03-03'),
('Alejandro', 'Sebastián', 'Vega', 'Campos', 'alejandro.vega@email.com', 'La Libertad, La Libertad', 'avega', '2024-03-05'),
('Camila', 'Andrea', 'Soto', 'Miranda', 'camila.soto@email.com', 'Nuevo Cuscatlán, La Libertad', 'csoto', '2024-03-08'),
('Sebastián', 'Andrés', 'Peña', 'Ríos', 'sebastian.pena@email.com', 'San Martín, San Salvador', 'spena', '2024-03-10'),
('Victoria', 'Eugenia', 'Salazar', 'Bravo', 'victoria.salazar@email.com', 'Ayutuxtepeque, San Salvador', 'vsalazar', '2024-03-12'),
('Matías', 'Emilio', 'Cortés', 'Arias', 'matias.cortes@email.com', 'Ciudad Delgado, San Salvador', 'mcortes', '2024-03-15'),
('Luciana', 'Valeria', 'Espinoza', 'Parra', 'luciana.espinoza@email.com', 'Tonacatepeque, San Salvador', 'lespinoza', '2024-03-18'),
('Emiliano', 'David', 'Contreras', 'Iglesias', 'emiliano.contreras@email.com', 'Opico, La Libertad', 'econtreras', '2024-03-20'),
('Renata', 'Paula', 'Sandoval', 'Paredes', 'renata.sandoval@email.com', 'Quezaltepeque, La Libertad', 'rsandoval', '2024-03-22'),
('Maximiliano', 'Tomás', 'Valenzuela', 'Tapia', 'maximiliano.valenzuela@email.com', 'Nejapa, San Salvador', 'mvalenzuela', '2024-03-25'),
('Martina', 'Josefina', 'Cabrera', 'León', 'martina.cabrera@email.com', 'Apaneca, Ahuachapán', 'mcabrera', '2024-03-28'),
('Benjamín', 'Nicolás', 'Fuentes', 'Escobar', 'benjamin.fuentes@email.com', 'Juayúa, Sonsonate', 'bfuentes', '2024-03-30'),
('Emma', 'Victoria', 'Araya', 'Cáceres', 'emma.araya@email.com', 'Concepción de Ataco, Ahuachapán', 'earaya', '2024-04-01'),
('Lucas', 'Mateo', 'Pizarro', 'Vera', 'lucas.pizarro@email.com', 'Suchitoto, Cuscatlán', 'lpizarro', '2024-04-03'),
('Olivia', 'Renata', 'Escobar', 'Cárdenas', 'olivia.escobar@email.com', 'Perquín, Morazán', 'oescobar', '2024-04-05'),
('Thiago', 'Alexander', 'Miranda', 'Figueroa', 'thiago.miranda@email.com', 'Joya de Cerén, La Libertad', 'tmiranda', '2024-04-08'),
('Isla', 'Marie', 'Duarte', 'Lagos', 'isla.duarte@email.com', 'Panchimalco, San Salvador', 'iduarte', '2024-04-10');
GO

-- Insertar Creadores (30 registros)
INSERT INTO Creador (nom_creador, estado, Usuario_idUsuario) VALUES
('Fundación Ayuda Solidaria', 'Activo', 1),
('Asociación Manos Unidas', 'Activo', 2),
('Comité Pro-Desarrollo', 'Activo', 3),
('Grupo Juvenil Esperanza', 'Activo', 4),
('Organización Ambiental Verde', 'Activo', 5),
('Centro Cultural Las Artes', 'Activo', 6),
('Fundación Educación Para Todos', 'Activo', 7),
('Asociación de Mujeres Emprendedoras', 'Activo', 8),
('Club Deportivo Juvenil', 'Activo', 9),
('Comunidad Terapéutica Renacer', 'Activo', 10),
('Fundación Pro-Animal', 'Activo', 11),
('Cooperativa de Artesanos', 'Activo', 12),
('Asociación de Padres de Familia', 'Activo', 13),
('Grupo Scout San Jorge', 'Activo', 14),
('Fundación Médica Solidaria', 'Activo', 15),
('Centro de Rehabilitación Integral', 'Activo', 16),
('Asociación de Productores Agrícolas', 'Activo', 17),
('Comité de Vecinos Unidos', 'Activo', 18),
('Fundación Pro-Deporte', 'Activo', 19),
('Orquesta Sinfónica Juvenil', 'Activo', 20),
('Asociación de Personas con Discapacidad', 'Activo', 21),
('Centro de Capacitación Laboral', 'Activo', 22),
('Fundación Pro-Niñez', 'Activo', 23),
('Grupo de Teatro Comunitario', 'Activo', 24),
('Asociación de Jóvenes Líderes', 'Activo', 25),
('Centro de Investigación Ambiental', 'Activo', 26),
('Fundación Cultural Patrimonio', 'Activo', 27),
('Comité de Desarrollo Local', 'Activo', 28),
('Asociación de Emprendedores Digitales', 'Activo', 29),
('Red de Voluntarios Solidarios', 'Activo', 30);
GO

-- Insertar Administradores (15 registros)
INSERT INTO Administrador (niv_acceso, departamento, Usuario_idUsuario) VALUES
('Super Administrador', 'Dirección General', 31),
('Administrador Senior', 'Gestión de Proyectos', 32),
('Administrador', 'Atención al Cliente', 33),
('Administrador', 'Finanzas', 34),
('Administrador Junior', 'Marketing', 35),
('Moderador', 'Comunidad', 1),
('Moderador', 'Contenido', 2),
('Analista', 'Reportes', 3),
('Coordinador', 'Eventos', 4),
('Coordinador', 'Donaciones', 5),
('Especialista', 'Comunicaciones', 6),
('Especialista', 'Soporte Técnico', 7),
('Asistente', 'Administración', 8),
('Asistente', 'Recursos Humanos', 9),
('Consultor', 'Estrategia', 10);
GO

-- Insertar Teléfonos (35 registros)
INSERT INTO Telefono (num_telefono, Usuario_idUsuario) VALUES
('+503 7123-4567', 1),
('+503 7234-5678', 2),
('+503 7345-6789', 3),
('+503 7456-7890', 4),
('+503 7567-8901', 5),
('+503 7678-9012', 6),
('+503 7789-0123', 7),
('+503 7890-1234', 8),
('+503 7901-2345', 9),
('+503 7012-3456', 10),
('+503 7123-4568', 11),
('+503 7234-5679', 12),
('+503 7345-6790', 13),
('+503 7456-7891', 14),
('+503 7567-8902', 15),
('+503 7678-9013', 16),
('+503 7789-0124', 17),
('+503 7890-1235', 18),
('+503 7901-2346', 19),
('+503 7012-3457', 20),
('+503 7123-4569', 21),
('+503 7234-5680', 22),
('+503 7345-6791', 23),
('+503 7456-7892', 24),
('+503 7567-8903', 25),
('+503 7678-9014', 26),
('+503 7789-0125', 27),
('+503 7890-1236', 28),
('+503 7901-2347', 29),
('+503 7012-3458', 30),
('+503 7123-4570', 31),
('+503 7234-5681', 32),
('+503 7345-6792', 33),
('+503 7456-7893', 34),
('+503 7567-8904', 35);
GO

-- Insertar Actividades (35 registros)
INSERT INTO Actividad (nom_actividad, fecha_inicio, fecha_fin, meta, Patrocinador_idPatrocinador, Tipo_Actividad_idTipo_Actividad) VALUES
('Carrera 5K por la Educación', '2024-05-01', '2024-05-01', 'Recaudar $10,000 para becas escolares', 1, 5),
('Subasta de Arte Solidario', '2024-05-15', '2024-05-15', 'Recaudar $15,000 para el hospital infantil', 2, 4),
('Concierto por la Paz', '2024-06-01', '2024-06-01', 'Recaudar $20,000 para comunidades afectadas', 3, 6),
('Campaña de Reforestación Nacional', '2024-06-15', '2024-06-30', 'Plantar 10,000 árboles', 4, 14),
('Maratón de Donación de Sangre', '2024-07-01', '2024-07-07', 'Recolectar 500 unidades de sangre', 5, 11),
('Festival Gastronómico Benéfico', '2024-07-15', '2024-07-17', 'Recaudar $8,000 para comedores infantiles', 6, 2),
('Talleres de Emprendimiento', '2024-08-01', '2024-08-31', 'Capacitar a 200 emprendedores', 7, 15),
('Campaña de Recolección de Útiles', '2024-08-15', '2024-09-15', 'Recolectar útiles para 1,000 niños', 8, 12),
('Evento de Adopción de Mascotas', '2024-09-01', '2024-09-01', 'Encontrar hogar a 100 mascotas', 9, 13),
('Crowdfunding para Biblioteca', '2024-09-15', '2024-10-15', 'Recaudar $25,000 para biblioteca comunitaria', 10, 9),
('Cena de Gala Anual', '2024-10-01', '2024-10-01', 'Recaudar $50,000 para proyectos sociales', 11, 7),
('Venta de Productos Artesanales', '2024-10-15', '2024-10-31', 'Apoyar a 50 familias artesanas', 12, 8),
('Campaña de Concienciación sobre Diabetes', '2024-11-01', '2024-11-30', 'Realizar 5,000 pruebas gratuitas', 13, 3),
('Recaudación de Fondos para Orquesta', '2024-11-15', '2024-12-15', 'Recaudar $12,000 para instrumentos', 14, 1),
('Voluntariado en Comunidades Rurales', '2024-12-01', '2024-12-20', 'Atender a 20 comunidades rurales', 15, 9),
('Carrera Nocturna Luminosa', '2024-12-15', '2024-12-15', 'Recaudar $18,000 para alumbrado público', 1, 5),
('Feria de Empleo para Jóvenes', '2025-01-15', '2025-01-16', 'Colocar a 500 jóvenes en empleos', 2, 15),
('Campaña de Prevención de Incendios', '2025-02-01', '2025-02-28', 'Capacitar a 2,000 personas', 3, 3),
('Torneo Deportivo Benéfico', '2025-02-15', '2025-02-16', 'Recaudar $6,000 para equipamiento', 4, 2),
('Exposición Fotográfica Solidaria', '2025-03-01', '2025-03-15', 'Recaudar $5,000 para fotógrafos jóvenes', 5, 2),
('Campaña de Donación de Alimentos', '2025-03-15', '2025-04-15', 'Recolectar 5 toneladas de alimentos', 6, 12),
('Hackathon Social', '2025-04-01', '2025-04-03', 'Desarrollar 10 soluciones tecnológicas', 7, 15),
('Festival Cultural Indígena', '2025-04-15', '2025-04-17', 'Preservar tradiciones culturales', 8, 2),
('Carrera Ciclística por la Salud', '2025-05-01', '2025-05-01', 'Promover el deporte y recaudar fondos', 9, 5),
('Subasta Silent por el Ambiente', '2025-05-15', '2025-05-15', 'Recaudar $10,000 para parques', 10, 4),
('Congreso de Voluntariado', '2025-06-01', '2025-06-03', 'Reunir a 1,000 voluntarios', 11, 9),
('Campaña de Vacunación Animal', '2025-06-15', '2025-06-30', 'Vacunar a 2,000 mascotas', 12, 13),
('Desfile de Moda Solidario', '2025-07-01', '2025-07-01', 'Apoyar a 35 diseñadores emergentes', 13, 2),
('Limpieza de Playas', '2025-07-15', '2025-07-15', 'Limpiar 10 playas del país', 14, 14),
('Festival de Cine Independiente', '2025-08-01', '2025-08-07', 'Apoyar a cineastas locales', 15, 2),
('Carrera de Obstáculos Extrema', '2025-08-15', '2025-08-15', 'Recaudar $20,000 para bomberos', 1, 5),
('Encuentro de Emprendedores', '2025-09-01', '2025-09-02', 'Conectar a 300 emprendedores', 2, 15),
('Campaña de Prevención del Dengue', '2025-09-15', '2025-10-15', 'Fumigar 5,000 hogares', 3, 3),
('Concierto de Rock Solidario', '2025-10-01', '2025-10-01', 'Recaudar $30,000 para música', 4, 6),
('Feria de Ciencias para Niños', '2025-10-15', '2025-10-17', 'Inspirar a 1,000 niños', 5, 15);
GO

PRINT 'Actividades insertadas exitosamente.';
GO

-- Insertar Donantes (35 registros)
INSERT INTO Donante (fecha_donacion, tipo_donacion, estado_Donacion, usuario_idUsuario) VALUES
('2024-01-20', 'Monetaria', 'Activa', 1),
('2024-01-22', 'Monetaria', 'Activa', 2),
('2024-01-25', 'En Especie', 'Activa', 3),
('2024-02-01', 'Monetaria', 'Activa', 4),
('2024-02-05', 'Monetaria', 'Activa', 5),
('2024-02-10', 'En Especie', 'Activa', 6),
('2024-02-15', 'Monetaria', 'Activa', 7),
('2024-02-20', 'Monetaria', 'Activa', 8),
('2024-02-25', 'En Especie', 'Activa', 9),
('2024-03-01', 'Monetaria', 'Activa', 10),
('2024-03-05', 'Monetaria', 'Activa', 11),
('2024-03-10', 'En Especie', 'Activa', 12),
('2024-03-15', 'Monetaria', 'Activa', 13),
('2024-03-20', 'Monetaria', 'Activa', 14),
('2024-03-25', 'En Especie', 'Activa', 15),
('2024-04-01', 'Monetaria', 'Activa', 16),
('2024-04-05', 'Monetaria', 'Activa', 17),
('2024-04-10', 'En Especie', 'Activa', 18),
('2024-04-15', 'Monetaria', 'Activa', 19),
('2024-04-20', 'Monetaria', 'Activa', 20),
('2024-04-25', 'En Especie', 'Activa', 21),
('2024-05-01', 'Monetaria', 'Activa', 22),
('2024-05-05', 'Monetaria', 'Activa', 23),
('2024-05-10', 'En Especie', 'Activa', 24),
('2024-05-15', 'Monetaria', 'Activa', 25),
('2024-05-20', 'Monetaria', 'Activa', 26),
('2024-05-25', 'En Especie', 'Activa', 27),
('2024-06-01', 'Monetaria', 'Activa', 28),
('2024-06-05', 'Monetaria', 'Activa', 29),
('2024-06-10', 'En Especie', 'Activa', 30),
('2024-06-15', 'Monetaria', 'Activa', 31),
('2024-06-20', 'Monetaria', 'Activa', 32),
('2024-06-25', 'En Especie', 'Activa', 33),
('2024-07-01', 'Monetaria', 'Activa', 34),
('2024-07-05', 'Monetaria', 'Activa', 35);
GO

-- Insertar Proyectos (35 registros)
INSERT INTO Proyecto (nombre_Proyecto, descripcion, fecha_Inicio, fecha_Fin, estado, Creador_idCreador) VALUES
('Becas Escolares 2024', 'Proyecto para otorgar becas a estudiantes de escasos recursos', '2024-01-01', '2024-12-31', 'Activo', 1),
('Hospital Infantil Renovado', 'Renovación de instalaciones del hospital infantil', '2024-02-01', '2024-08-31', 'Activo', 2),
('Comunidades Unidas', 'Apoyo a comunidades afectadas por desastres naturales', '2024-03-01', '2024-09-30', 'Activo', 3),
('Reforestación Nacional', 'Proyecto de reforestación en zonas críticas', '2024-04-01', '2024-12-31', 'Activo', 4),
('Banco de Sangre Digital', 'Modernización del sistema de donación de sangre', '2024-01-15', '2024-07-15', 'Activo', 5),
('Comedores Infantiles', 'Mantenimiento y equipamiento de comedores infantiles', '2024-02-15', '2024-12-31', 'Activo', 6),
('Emprendedores del Futuro', 'Capacitación y financiamiento de emprendedores', '2024-03-15', '2024-09-15', 'Activo', 7),
('Útiles para Todos', 'Entrega de útiles escolares a niños necesitados', '2024-04-15', '2024-10-15', 'Activo', 8),
('Hogar Animal', 'Construcción de refugio para animales abandonados', '2024-05-01', '2024-11-30', 'Activo', 9),
('Biblioteca Comunitaria', 'Construcción de biblioteca en zona rural', '2024-06-01', '2025-06-01', 'Activo', 10),
('Gala Anual Solidaria', 'Evento anual de recaudación de fondos', '2024-07-01', '2024-10-01', 'Activo', 11),
('Artesanías con Amor', 'Apoyo a artesanos locales para comercialización', '2024-08-01', '2024-12-31', 'Activo', 12),
('Salud Preventiva', 'Campañas de prevención y detección temprana', '2024-01-01', '2024-12-31', 'Activo', 13),
('Orquesta Juvenil', 'Compra de instrumentos para orquesta juvenil', '2024-02-01', '2024-08-31', 'Activo', 14),
('Voluntarios en Acción', 'Programa de voluntariado en comunidades', '2024-03-01', '2024-12-31', 'Activo', 15),
('Alumbrado Público Solar', 'Instalación de luminarias solares en comunidades', '2024-04-01', '2024-10-31', 'Activo', 16),
('Empleo Joven', 'Programa de inserción laboral para jóvenes', '2025-01-01', '2025-12-31', 'Activo', 17),
('Prevención de Incendios', 'Capacitación y equipamiento de brigadas', '2025-02-01', '2025-08-31', 'Activo', 18),
('Deporte para Todos', 'Equipamiento de canchas y espacios deportivos', '2025-03-01', '2025-09-30', 'Activo', 19),
('Fotografía Social', 'Exposición y venta de fotografía documental', '2025-04-01', '2025-10-31', 'Activo', 20),
('Banco de Alimentos', 'Recolección y distribución de alimentos', '2025-05-01', '2025-11-30', 'Activo', 21),
('Tech Solutions', 'Desarrollo de soluciones tecnológicas sociales', '2025-06-01', '2025-12-31', 'Activo', 22),
('Raíces Culturales', 'Preservación de tradiciones indígenas', '2025-07-01', '2025-12-31', 'Activo', 23),
('Ciclismo para la Salud', 'Promoción del ciclismo como deporte', '2025-08-01', '2025-12-31', 'Activo', 24),
('Parques Verdes', 'Recuperación y mantenimiento de parques', '2025-09-01', '2025-12-31', 'Activo', 25),
('Congreso Voluntariado', 'Organización de congreso nacional', '2025-10-01', '2025-12-31', 'Activo', 26),
('Mascotas Saludables', 'Campaña de vacunación y esterilización', '2025-11-01', '2025-12-31', 'Activo', 27),
('Moda con Propósito', 'Apoyo a diseñadores emergentes', '2025-12-01', '2025-12-31', 'Activo', 28),
('Playas Limpias', 'Conservación de ecosistemas marinos', '2024-05-01', '2024-12-31', 'Activo', 29),
('Cine Independiente', 'Apoyo a producción cinematográfica local', '2024-06-01', '2024-12-31', 'Activo', 30),
('Bomberos Equipados', 'Compra de equipo para cuerpo de bomberos', '2024-07-01', '2024-12-31', 'Activo', 1),
('Red de Emprendedores', 'Plataforma de conexión empresarial', '2024-08-01', '2024-12-31', 'Activo', 2),
('Dengue Cero', 'Campaña de prevención del dengue', '2024-09-01', '2024-12-31', 'Activo', 3),
('Rock por la Paz', 'Concierto benéfico de rock', '2024-10-01', '2024-12-31', 'Activo', 4),
('Pequeños Científicos', 'Feria de ciencias para niños', '2024-11-01', '2024-12-31', 'Activo', 5);
GO

-- Insertar Donaciones (40 registros)
INSERT INTO Donacion (monto, anonima, mensaje, fecha, Usuario_idUsuario, Donante_idDonante, Proyecto_idProyecto) VALUES
(100.00, 'NO', 'Con mucho cariño para los niños', '2024-01-20', 1, 1, 1),
(250.50, 'NO', 'Espero que ayude mucho', '2024-01-22', 2, 2, 1),
(500.00, 'SI', NULL, '2024-01-25', 3, 3, 2),
(75.00, 'NO', 'Para la educación de todos', '2024-02-01', 4, 4, 2),
(1000.00, 'NO', 'Gran iniciativa, felicidades', '2024-02-05', 5, 5, 3),
(150.00, 'SI', NULL, '2024-02-10', 6, 6, 3),
(300.00, 'NO', 'Por un mundo mejor', '2024-02-15', 7, 7, 4),
(50.00, 'NO', 'Lo poco que puedo aportar', '2024-02-20', 8, 8, 4),
(2000.00, 'NO', 'Con todo mi apoyo', '2024-02-25', 9, 9, 5),
(125.00, 'SI', NULL, '2024-03-01', 10, 10, 5),
(450.00, 'NO', 'Excelente proyecto', '2024-03-05', 11, 11, 6),
(80.00, 'NO', 'Para los niños del comedor', '2024-03-10', 12, 12, 6),
(600.00, 'SI', NULL, '2024-03-15', 13, 13, 7),
(175.00, 'NO', 'Apoyando el emprendimiento', '2024-03-20', 14, 14, 7),
(900.00, 'NO', 'Por la educación', '2024-03-25', 15, 15, 8),
(200.00, 'SI', NULL, '2024-04-01', 16, 16, 8),
(350.00, 'NO', 'Para los animalitos', '2024-04-05', 17, 17, 9),
(120.00, 'NO', 'Adopten no compren', '2024-04-10', 18, 18, 9),
(1500.00, 'NO', 'Conocimiento para todos', '2024-04-15', 19, 19, 10),
(225.00, 'SI', NULL, '2024-04-20', 20, 20, 10),
(550.00, 'NO', 'Gran causa', '2024-04-25', 21, 21, 11),
(95.00, 'NO', 'Para las familias artesanas', '2024-05-01', 22, 22, 12),
(400.00, 'SI', NULL, '2024-05-05', 23, 23, 12),
(180.00, 'NO', 'Salud para todos', '2024-05-10', 24, 24, 13),
(750.00, 'NO', 'Por la música', '2024-05-15', 25, 25, 14),
(140.00, 'SI', NULL, '2024-05-20', 26, 26, 14),
(320.00, 'NO', 'Voluntariado es amor', '2024-05-25', 27, 27, 15),
(65.00, 'NO', 'Para alumbrar comunidades', '2024-06-01', 28, 28, 16),
(850.00, 'NO', 'Empleo para los jóvenes', '2024-06-05', 29, 29, 17),
(110.00, 'SI', NULL, '2024-06-10', 30, 30, 17),
(480.00, 'NO', 'Prevención es vida', '2024-06-15', 31, 31, 18),
(190.00, 'NO', 'Deporte es salud', '2024-06-20', 32, 32, 19),
(670.00, 'SI', NULL, '2024-06-25', 33, 33, 20),
(135.00, 'NO', 'Para que nadie pase hambre', '2024-07-01', 34, 34, 21),
(920.00, 'NO', 'Tecnología con propósito', '2024-07-05', 35, 35, 22),
(210.00, 'SI', NULL, '2024-07-10', 1, 1, 22),
(380.00, 'NO', 'Nuestras raíces importan', '2024-07-15', 2, 2, 23),
(155.00, 'NO', 'Pedaleando por la salud', '2024-07-20', 3, 3, 24),
(580.00, 'NO', 'Parques para las familias', '2024-07-25', 4, 4, 25),
(245.00, 'SI', NULL, '2024-08-01', 5, 5, 25);
GO

-- Insertar Beneficiarios (35 registros)
INSERT INTO Beneficiario (nom, contacto, descripcion, Actividad_idActividad) VALUES
('Escuela Primaria San José', '+503 2222-1001', 'Escuela rural con 200 estudiantes', 1),
('Hospital Infantil Nacional', '+503 2222-1002', 'Principal hospital pediátrico del país', 2),
('Comunidad El Progreso', '+503 2222-1003', 'Comunidad afectada por inundaciones', 3),
('Reserva Natural Los Volcanes', '+503 2222-1004', 'Área protegida necesitando reforestación', 4),
('Cruz Roja Salvadoreña', '+503 2222-1005', 'Institución de salud y emergencias', 5),
('Comedor Infantil Los Ángeles', '+503 2222-1006', 'Comedor para 150 niños diarios', 6),
('Centro de Emprendedores', '+503 2222-1007', 'Espacio de capacitación empresarial', 7),
('Escuela Rural Las Flores', '+503 2222-1008', 'Escuela con 80 estudiantes de escasos recursos', 8),
('Refugio Animal Patitas', '+503 2222-1009', 'Albergue para 200 mascotas', 9),
('Comunidad El Carmen', '+503 2222-1010', 'Zona rural sin acceso a biblioteca', 10),
('Fundación Niños Felices', '+503 2222-1011', 'Organización de ayuda infantil', 11),
('Cooperativa de Artesanos', '+503 2222-1012', 'Grupo de 50 familias artesanas', 12),
('Clínica de la Mujer', '+503 2222-1013', 'Centro de salud femenina', 13),
('Escuela de Música Juvenil', '+503 2222-1014', 'Escuela con 120 estudiantes de música', 14),
('Comunidad San Rafael', '+503 2222-1015', 'Comunidad rural con necesidades diversas', 15),
('Barrio El Sol', '+503 2222-1016', 'Comunidad sin alumbrado público', 16),
('Centro Juvenil de Empleo', '+503 2222-1017', 'Institución de capacitación laboral', 17),
('Cuerpo de Bomberos', '+503 2222-1018', 'Estación de bomberos local', 18),
('Club Deportivo San Martín', '+503 2222-1019', 'Club con 300 deportistas', 19),
('Asociación de Fotógrafos', '+503 2222-1020', 'Colectivo de 25 fotógrafos', 20),
('Banco de Alimentos Nacional', '+503 2222-1021', 'Institución distribuidora de alimentos', 21),
('Startup El Salvador', '+503 2222-1022', 'Aceleradora de startups', 22),
('Comunidad Indígena Náhuat', '+503 2222-1023', 'Comunidad preservando tradiciones', 23),
('Club Ciclístico Urbano', '+503 2222-1024', 'Club con 150 ciclistas', 24),
('Parque Central Municipal', '+503 2222-1025', 'Parque principal de la ciudad', 25),
('Red Nacional de Voluntarios', '+503 2222-1026', 'Red con 5,000 voluntarios', 26),
('Clínica Veterinaria Municipal', '+503 2222-1027', 'Centro de atención animal', 27),
('Diseñadores Emergentes SV', '+503 2222-1028', 'Colectivo de 40 diseñadores', 28),
('Comité de Playas Limpias', '+503 2222-1029', 'Organización ambientalista', 29),
('Asociación de Cineastas', '+503 2222-1030', 'Colectivo de 30 cineastas', 30),
('Estación de Bomberos Central', '+503 2222-1031', 'Estación principal del país', 31),
('Cámara de Emprendedores', '+503 2222-1032', 'Organización empresarial', 32),
('Ministerio de Salud', '+503 2222-1033', 'Institución gubernamental de salud', 33),
('Productores de Rock Local', '+503 2222-1034', 'Colectivo de 20 bandas', 34),
('Escuelas Rurales del Norte', '+503 2222-1035', 'Red de 15 escuelas rurales', 35);
GO

-- Insertar Pagos (35 registros)
INSERT INTO Pago (monto, fecha, estado, referencia, Donacion_idDonacion) VALUES
(100.00, '2024-01-20', 'Completado', 'PAY-001', 1),
(250.50, '2024-01-22', 'Completado', 'PAY-002', 2),
(500.00, '2024-01-25', 'Completado', 'PAY-003', 3),
(75.00, '2024-02-01', 'Completado', 'PAY-004', 4),
(1000.00, '2024-02-05', 'Completado', 'PAY-005', 5),
(150.00, '2024-02-10', 'Pendiente', 'PAY-006', 6),
(300.00, '2024-02-15', 'Completado', 'PAY-007', 7),
(50.00, '2024-02-20', 'Completado', 'PAY-008', 8),
(2000.00, '2024-02-25', 'Completado', 'PAY-009', 9),
(125.00, '2024-03-01', 'Completado', 'PAY-010', 10),
(450.00, '2024-03-05', 'Completado', 'PAY-011', 11),
(80.00, '2024-03-10', 'Pendiente', 'PAY-012', 12),
(600.00, '2024-03-15', 'Completado', 'PAY-013', 13),
(175.00, '2024-03-20', 'Completado', 'PAY-014', 14),
(900.00, '2024-03-25', 'Completado', 'PAY-015', 15),
(200.00, '2024-04-01', 'Completado', 'PAY-016', 16),
(350.00, '2024-04-05', 'Completado', 'PAY-017', 17),
(120.00, '2024-04-10', 'Pendiente', 'PAY-018', 18),
(1500.00, '2024-04-15', 'Completado', 'PAY-019', 19),
(225.00, '2024-04-20', 'Completado', 'PAY-020', 20),
(550.00, '2024-04-25', 'Completado', 'PAY-021', 21),
(95.00, '2024-05-01', 'Completado', 'PAY-022', 22),
(400.00, '2024-05-05', 'Completado', 'PAY-023', 23),
(180.00, '2024-05-10', 'Pendiente', 'PAY-024', 24),
(750.00, '2024-05-15', 'Completado', 'PAY-025', 25),
(140.00, '2024-05-20', 'Completado', 'PAY-026', 26),
(320.00, '2024-05-25', 'Completado', 'PAY-027', 27),
(65.00, '2024-06-01', 'Completado', 'PAY-028', 28),
(850.00, '2024-06-05', 'Completado', 'PAY-029', 29),
(110.00, '2024-06-10', 'Pendiente', 'PAY-030', 30),
(480.00, '2024-06-15', 'Completado', 'PAY-031', 31),
(190.00, '2024-06-20', 'Completado', 'PAY-032', 32),
(670.00, '2024-06-25', 'Completado', 'PAY-033', 33),
(135.00, '2024-07-01', 'Completado', 'PAY-034', 34),
(920.00, '2024-07-05', 'Completado', 'PAY-035', 35);
GO

PRINT 'Datos transaccionales principales insertados exitosamente.';
GO

-- Insertar Reportes (35 registros)
INSERT INTO Reporte (mensaje, fecha, motivo, estado, descripcion, Usuario_idUsuario, Administrador_idAdministrador, Actividad_idActividad) VALUES
('Reporte de actividad sospechosa', '2024-01-25', 'Comportamiento Inapropiado', 'Pendiente', 'Usuario reporta comportamiento inadecuado en comentarios', 1, 1, 1),
('Solicitud de información', '2024-02-01', 'Consulta General', 'Resuelto', 'Usuario solicita más información sobre el proyecto', 2, 2, 2),
('Denuncia de fraude', '2024-02-10', 'Fraude', 'En Investigación', 'Usuario reporta posible actividad fraudulenta', 3, 3, 3),
('Reporte de error en página', '2024-02-15', 'Error Técnico', 'Resuelto', 'Usuario no puede completar su donación', 4, 4, 4),
('Solicitud de reembolso', '2024-03-01', 'Reembolso', 'Pendiente', 'Usuario solicita reembolso por donación duplicada', 5, 5, 5),
('Reporte de contenido inapropiado', '2024-03-10', 'Contenido Inapropiado', 'Resuelto', 'Imagen ofensiva en publicación', 6, 6, 6),
('Consulta sobre proyecto', '2024-03-15', 'Consulta General', 'Resuelto', 'Preguntas sobre uso de fondos', 7, 7, 7),
('Denuncia de acoso', '2024-03-20', 'Acoso', 'En Investigación', 'Usuario reporta acoso en foro', 8, 8, 8),
('Reporte de actividad completada', '2024-04-01', 'Actualización', 'Resuelto', 'Actividad ha finalizado exitosamente', 9, 9, 9),
('Solicitud de verificación', '2024-04-05', 'Verificación', 'Pendiente', 'Creador solicita verificación de cuenta', 10, 10, 10),
('Reporte de spam', '2024-04-10', 'Spam', 'Resuelto', 'Múltiples mensajes publicitarios', 11, 11, 11),
('Consulta de donación', '2024-04-15', 'Consulta General', 'Resuelto', 'Duda sobre recibo de donación', 12, 12, 12),
('Denuncia de identidad falsa', '2024-04-20', 'Fraude', 'En Investigación', 'Posible perfil falso de creador', 13, 13, 13),
('Reporte de meta alcanzada', '2024-05-01', 'Actualización', 'Resuelto', 'Proyecto ha alcanzado su meta de recaudación', 14, 14, 14),
('Solicitud de soporte', '2024-05-05', 'Soporte Técnico', 'Pendiente', 'Problema para subir documentación', 15, 15, 15),
('Reporte de comentario ofensivo', '2024-05-10', 'Contenido Inapropiado', 'Resuelto', 'Comentario discriminatorio en foro', 16, 1, 16),
('Consulta sobre recompensa', '2024-05-15', 'Consulta General', 'Resuelto', 'Pregunta sobre entrega de recompensa', 17, 2, 17),
('Denuncia de plagio', '2024-05-20', 'Propiedad Intelectual', 'En Investigación', 'Proyecto copia idea de otro creador', 18, 3, 18),
('Reporte de actividad cancelada', '2024-06-01', 'Actualización', 'Resuelto', 'Actividad cancelada por emergencia', 19, 4, 19),
('Solicitud de cambio de datos', '2024-06-05', 'Actualización de Datos', 'Pendiente', 'Usuario solicita cambiar correo registrado', 20, 5, 20),
('Reporte de enlace roto', '2024-06-10', 'Error Técnico', 'Resuelto', 'Enlace de donación no funciona', 21, 6, 21),
('Consulta sobre impuestos', '2024-06-15', 'Consulta General', 'Resuelto', 'Pregunta sobre deducción de donaciones', 22, 7, 22),
('Denuncia de múltiples cuentas', '2024-06-20', 'Fraude', 'En Investigación', 'Usuario con múltiples cuentas para votar', 23, 8, 23),
('Reporte de meta extendida', '2024-07-01', 'Actualización', 'Resuelto', 'Meta de recaudación ha sido extendida', 24, 9, 24),
('Solicitud de eliminación de cuenta', '2024-07-05', 'Eliminación de Cuenta', 'Pendiente', 'Usuario solicita eliminar su cuenta', 25, 10, 25),
('Reporte de publicidad engañosa', '2024-07-10', 'Publicidad Engañosa', 'En Investigación', 'Proyecto promete lo que no cumple', 26, 11, 26),
('Consulta sobre patrocinio', '2024-07-15', 'Consulta General', 'Resuelto', 'Empresa interesada en patrocinar', 27, 12, 27),
('Denuncia de discriminación', '2024-07-20', 'Discriminación', 'En Investigación', 'Proyecto excluye a ciertos grupos', 28, 13, 28),
('Reporte de evento exitoso', '2024-08-01', 'Actualización', 'Resuelto', 'Evento superó expectativas de asistencia', 29, 14, 29),
('Solicitud de reporte de donaciones', '2024-08-05', 'Reporte', 'Pendiente', 'Usuario solicita reporte de sus donaciones', 30, 15, 30),
('Reporte de comportamiento sospechoso', '2024-08-10', 'Comportamiento Inapropiado', 'En Investigación', 'Patrón inusual de donaciones', 31, 1, 31),
('Consulta sobre voluntariado', '2024-08-15', 'Consulta General', 'Resuelto', 'Información sobre cómo ser voluntario', 32, 2, 32),
('Denuncia de incumplimiento', '2024-08-20', 'Incumplimiento', 'En Investigación', 'Proyecto no entrega recompensas prometidas', 33, 3, 33),
('Reporte de sistema lento', '2024-09-01', 'Error Técnico', 'Pendiente', 'Página carga muy lentamente', 34, 4, 34),
('Solicitud de colaboración', '2024-09-05', 'Colaboración', 'Resuelto', 'Organización quiere colaborar con plataforma', 35, 5, 35);
GO

-- Insertar Reseñas (35 registros)
INSERT INTO Reseña (descripcion, usuario_idUsuario, Actividad_idActividad) VALUES
('Excelente iniciativa, muy bien organizada', 1, 1),
('Gran proyecto, cumplió con todas las expectativas', 2, 2),
('Me encantó participar, lo recomiendo', 3, 3),
('Muy buena causa, felicidades a los organizadores', 4, 4),
('Increíble experiencia, volvería a donar', 5, 5),
('Todo salió perfecto, excelente gestión', 6, 6),
('Un proyecto que realmente hace la diferencia', 7, 7),
('Muy transparentes con el uso de los fondos', 8, 8),
('Los beneficiarios quedaron muy agradecidos', 9, 9),
('Hermosa labor social, admiro su trabajo', 10, 10),
('Todo muy profesional y bien organizado', 11, 11),
('El evento fue un éxito total', 12, 12),
('Gran impacto en la comunidad', 13, 13),
('Música excelente, gran causa', 14, 14),
('Los voluntarios fueron muy dedicados', 15, 15),
('Las luminarias han cambiado la comunidad', 16, 16),
('Muchos jóvenes encontraron empleo', 17, 17),
('La capacitación fue muy útil', 18, 18),
('Las canchas quedaron espectaculares', 19, 19),
('Fotografías muy emotivas', 20, 20),
('Muchas familias recibieron alimentos', 21, 21),
('Soluciones tecnológicas innovadoras', 22, 22),
('Hermoso rescate cultural', 23, 23),
('Gran ambiente deportivo', 24, 24),
('Los parques lucen renovados', 25, 25),
('Excelente organización del congreso', 26, 26),
('Muchas mascotas fueron atendidas', 27, 27),
('Diseños muy creativos', 28, 28),
('Playas más limpias que nunca', 29, 29),
('Películas de gran calidad', 30, 30),
('Bomberos muy agradecidos', 31, 31),
('Gran networking empresarial', 32, 32),
('Campaña muy efectiva', 33, 33),
('Concierto inolvidable', 34, 34),
('Niños muy inspirados', 35, 35);
GO

-- Insertar Movimientos (35 registros)
INSERT INTO Movimiento (Pago_idPago, Forma_Pago_idForma_Pago, monto) VALUES
(1, 1, 100.00),
(2, 2, 250.50),
(3, 3, 500.00),
(4, 4, 75.00),
(5, 5, 1000.00),
(6, 6, 150.00),
(7, 7, 300.00),
(8, 8, 50.00),
(9, 9, 2000.00),
(10, 10, 125.00),
(11, 11, 450.00),
(12, 12, 80.00),
(13, 13, 600.00),
(14, 14, 175.00),
(15, 15, 900.00),
(16, 1, 200.00),
(17, 2, 350.00),
(18, 3, 120.00),
(19, 4, 1500.00),
(20, 5, 225.00),
(21, 6, 550.00),
(22, 7, 95.00),
(23, 8, 400.00),
(24, 9, 180.00),
(25, 10, 750.00),
(26, 11, 140.00),
(27, 12, 320.00),
(28, 13, 65.00),
(29, 14, 850.00),
(30, 15, 110.00),
(31, 1, 480.00),
(32, 2, 190.00),
(33, 3, 670.00),
(34, 4, 135.00),
(35, 5, 920.00);
GO

-- Insertar DetalleComprobante (35 registros)
INSERT INTO DetalleComprobante (Movimiento_Pago_idPago, Movimiento_Forma_Pago_idForma_Pago, Factura_idFactura, usuario_idUsuario, Monto, Estado) VALUES
(1, 1, 1, 1, 100.00, 'Emitido'),
(2, 2, 2, 2, 250.50, 'Emitido'),
(3, 3, 3, 3, 500.00, 'Emitido'),
(4, 4, 4, 4, 75.00, 'Emitido'),
(5, 5, 5, 5, 1000.00, 'Emitido'),
(6, 6, 6, 6, 150.00, 'Pendiente'),
(7, 7, 7, 7, 300.00, 'Emitido'),
(8, 8, 8, 8, 50.00, 'Emitido'),
(9, 9, 9, 9, 2000.00, 'Emitido'),
(10, 10, 10, 10, 125.00, 'Emitido'),
(11, 11, 11, 11, 450.00, 'Emitido'),
(12, 12, 12, 12, 80.00, 'Pendiente'),
(13, 13, 13, 13, 600.00, 'Emitido'),
(14, 14, 14, 14, 175.00, 'Emitido'),
(15, 15, 15, 15, 900.00, 'Emitido'),
(16, 1, 1, 16, 200.00, 'Emitido'),
(17, 2, 2, 17, 350.00, 'Emitido'),
(18, 3, 3, 18, 120.00, 'Pendiente'),
(19, 4, 4, 19, 1500.00, 'Emitido'),
(20, 5, 5, 20, 225.00, 'Emitido'),
(21, 6, 6, 21, 550.00, 'Emitido'),
(22, 7, 7, 22, 95.00, 'Emitido'),
(23, 8, 8, 23, 400.00, 'Emitido'),
(24, 9, 9, 24, 180.00, 'Pendiente'),
(25, 10, 10, 25, 750.00, 'Emitido'),
(26, 11, 11, 26, 140.00, 'Emitido'),
(27, 12, 12, 27, 320.00, 'Emitido'),
(28, 13, 13, 28, 65.00, 'Emitido'),
(29, 14, 14, 29, 850.00, 'Emitido'),
(30, 15, 15, 30, 110.00, 'Pendiente'),
(31, 1, 1, 31, 480.00, 'Emitido'),
(32, 2, 2, 32, 190.00, 'Emitido'),
(33, 3, 3, 33, 670.00, 'Emitido'),
(34, 4, 4, 34, 135.00, 'Emitido'),
(35, 5, 5, 35, 920.00, 'Emitido');
GO

-- Insertar Reembolsos (20 registros)
INSERT INTO reembolso (fecha, motivo, descripcion, Pago_idPago) VALUES
('2024-02-15', 'Donación duplicada', 'Usuario realizó donación dos veces por error', 6),
('2024-03-20', 'Cambio de decisión', 'Usuario solicita reembolso por cambio de opinión', 12),
('2024-04-25', 'Proyecto cancelado', 'Proyecto fue cancelado por el creador', 18),
('2024-05-30', 'Error en monto', 'Usuario ingresó monto incorrecto', 24),
('2024-06-15', 'Fraude detectado', 'Actividad fraudulenta identificada', 30),
('2024-07-10', 'Donación no reconocida', 'Usuario no reconoce la transacción', 1),
('2024-08-05', 'Insatisfacción', 'Usuario insatisfecho con el proyecto', 7),
('2024-09-01', 'Proyecto incumplido', 'Proyecto no cumplió con lo prometido', 13),
('2024-09-20', 'Error técnico', 'Error en procesamiento de pago', 19),
('2024-10-15', 'Solicitud de usuario', 'Usuario solicita reembolso personal', 25),
('2024-11-01', 'Duplicidad', 'Transacción duplicada en sistema', 31),
('2024-11-20', 'Cancelación de evento', 'Evento fue cancelado', 2),
('2024-12-05', 'Cambio de proyecto', 'Usuario quiere donar a otro proyecto', 8),
('2024-12-20', 'Error de sistema', 'Error en el sistema de pagos', 14),
('2025-01-10', 'Revisión administrativa', 'Reembolso aprobado por revisión', 20),
('2025-02-01', 'Queja formal', 'Queja formal de usuario atendida', 26),
('2025-02-20', 'Acuerdo mutuo', 'Acuerdo entre usuario y creador', 32),
('2025-03-15', 'Política de reembolso', 'Aplicación de política de reembolso', 3),
('2025-04-10', 'Investigación', 'Resultado de investigación interna', 9),
('2025-05-01', 'Gestión de calidad', 'Medida de gestión de calidad', 15);
GO

-- Insertar Noticias (35 registros)
INSERT INTO Noticia (titulo, contenido, fechaPublicacion, Administrador_idAdministrador, Actividad_idActividad) VALUES
('Carrera 5K Supera Expectativas', 'La carrera benéfica recaudó $15,000, superando la meta inicial de $10,000. Más de 500 participantes se unieron a la causa.', '2024-05-02', 1, 1),
('Subasta de Arte un Éxito Rotundo', 'Obras de artistas locales fueron vendidas recaudando $18,000 para el hospital infantil.', '2024-05-16', 2, 2),
('Concierto por la Paz Reúne a Miles', 'Más de 10,000 personas asistieron al concierto benéfico en el estadio nacional.', '2024-06-02', 3, 3),
('Reforestación Nacional Inicia', 'El proyecto de reforestación comenzó con la plantación de 2,000 árboles en la primera semana.', '2024-06-16', 4, 4),
('Maratón de Sangre Salva Vidas', 'Se recolectaron 600 unidades de sangre, superando la meta de 500 unidades.', '2024-07-08', 5, 5),
('Festival Gastronómico Deleita a Todos', 'Chefs locales prepararon platillos especiales recaudando fondos para comedores infantiles.', '2024-07-18', 6, 6),
('Talleres de Emprendimiento Inician', '200 emprendedores comenzaron su capacitación en el programa anual.', '2024-08-02', 7, 7),
('Campaña de Útiles Escolares Exitosa', 'Se recolectaron útiles para 1,200 niños, superando la meta de 1,000.', '2024-09-16', 8, 8),
('100 Mascotas Encontraron Hogar', 'El evento de adopción fue un éxito con 100 adopciones confirmadas.', '2024-09-02', 9, 9),
('Biblioteca Comunitaria Avanza', 'La construcción de la biblioteca está 50% completada gracias a las donaciones.', '2024-09-16', 10, 10),
('Cena de Gala Recauda $60,000', 'La cena anual superó todas las expectativas con la participación de 300 donantes.', '2024-10-02', 11, 11),
('Artesanos Venden Sus Productos', 'La feria de artesanías benefició a 50 familias con ventas superiores a $10,000.', '2024-11-01', 12, 12),
('Campaña de Diabetes Alcanza Meta', 'Se realizaron 6,000 pruebas gratuitas de detección de diabetes.', '2024-12-01', 13, 13),
('Orquesta Recibe Nuevos Instrumentos', 'La donación permitió comprar 20 instrumentos musicales nuevos.', '2024-12-16', 14, 14),
('Voluntarios Atienden 25 Comunidades', 'El programa de voluntariado superó su meta atendiendo 25 comunidades.', '2024-12-25', 15, 15),
('Carrera Nocturna Ilumina la Ciudad', '5,000 corredores participaron en la carrera nocturna benéfica.', '2024-12-16', 1, 16),
('Feria de Empleo Coloca a 600 Jóvenes', 'La feria superó su meta colocando a 600 jóvenes en empleos formales.', '2025-01-17', 2, 17),
('Capacitación en Prevención de Incendios', '2,500 personas fueron capacitadas en prevención y respuesta a incendios.', '2025-03-01', 3, 18),
('Torneo Deportivo Reúne a 50 Equipos', 'El torneo benéfico contó con la participación de 50 equipos deportivos.', '2025-02-17', 4, 19),
('Exposición Fotográfica Emociona', 'La exposición recibió 5,000 visitantes en dos semanas.', '2025-03-16', 5, 20),
('Banco de Alimentos Recibe 6 Toneladas', 'La campaña de recolección superó su meta con 6 toneladas de alimentos.', '2025-04-16', 6, 21),
('Hackathon Desarrolla 15 Soluciones', 'El evento tecnológico superó expectativas con 15 proyectos innovadores.', '2025-04-04', 7, 22),
('Festival Cultural Preserva Tradiciones', 'Más de 20 comunidades indígenas participaron en el festival.', '2025-04-18', 8, 23),
('Carrera Ciclística Promueve Salud', '800 ciclistas participaron en la carrera por la salud.', '2025-05-02', 9, 24),
('Subasta Silent Recauda $12,000', 'La subasta silenciosa benefició los parques municipales.', '2025-05-16', 10, 25),
('Congreso Reúne a 1,200 Voluntarios', 'El congreso nacional de voluntariado fue todo un éxito.', '2025-06-04', 11, 26),
('Campaña Vacuna a 2,500 Mascotas', 'La campaña de vacunación superó su meta inicial.', '2025-07-01', 12, 27),
('Desfile de Moda Apoya a Diseñadores', '40 diseñadores emergentes presentaron sus colecciones.', '2025-07-02', 13, 28),
('Limpieza de Playas Recoge 2 Toneladas', 'Voluntarios recolectaron 2 toneladas de basura de las playas.', '2025-07-16', 14, 29),
('Festival de Cine Muestra 50 Películas', 'El festival presentó producciones locales e internacionales.', '2025-08-08', 15, 30),
('Carrera de Obstáculos Desafía a 800', 'La carrera extrema recaudó $25,000 para bomberos.', '2025-08-16', 1, 31),
('Encuentro Conecta a 400 Emprendedores', 'El evento de networking fue muy exitoso.', '2025-09-03', 2, 32),
('Campaña Fumiga 6,000 Hogares', 'La campaña de prevención del dengue superó su meta.', '2025-10-01', 3, 33),
('Concierto de Rock Reúne a 15,000', 'El concierto benéfico fue un éxito rotundo.', '2025-10-02', 4, 34),
('Feria de Ciencias Inspira a 1,200 Niños', 'Los niños disfrutaron de experimentos y talleres científicos.', '2025-10-18', 5, 35);
GO

PRINT 'Datos transaccionales adicionales insertados exitosamente.';
GO

-- Insertar Marketing (20 registros)
INSERT INTO Marketing (nombre, descripcion, fechaInicio, fechaFin, Administrador_idAdministrador, Proyecto_idProyecto) VALUES
('Campaña Becas 2024', 'Promoción del programa de becas escolares en redes sociales', '2024-01-01', '2024-03-31', 1, 1),
('Hospital Infantil Renovado', 'Campaña de recaudación para renovación hospitalaria', '2024-02-01', '2024-05-31', 2, 2),
('Comunidades Unidas', 'Difusión de proyecto de apoyo a comunidades afectadas', '2024-03-01', '2024-06-30', 3, 3),
('Reforestación Nacional', 'Campaña ambiental para reforestación', '2024-04-01', '2024-07-31', 4, 4),
('Banco de Sangre Digital', 'Promoción de donación de sangre', '2024-01-15', '2024-04-15', 5, 5),
('Comedores Infantiles', 'Campaña de recaudación para comedores', '2024-02-15', '2024-05-15', 6, 6),
('Emprendedores del Futuro', 'Promoción de programa de emprendimiento', '2024-03-15', '2024-06-15', 7, 7),
('Útiles para Todos', 'Campaña de recolección de útiles escolares', '2024-04-15', '2024-07-15', 8, 8),
('Hogar Animal', 'Promoción de adopción de mascotas', '2024-05-01', '2024-08-31', 9, 9),
('Biblioteca Comunitaria', 'Campaña para construcción de biblioteca', '2024-06-01', '2024-09-30', 10, 10),
('Gala Anual Solidaria', 'Promoción de evento de gala', '2024-07-01', '2024-10-01', 11, 11),
('Artesanías con Amor', 'Difusión de productos artesanales', '2024-08-01', '2024-11-30', 12, 12),
('Salud Preventiva', 'Campaña de concienciación sobre salud', '2024-01-01', '2024-04-30', 13, 13),
('Orquesta Juvenil', 'Promoción de recaudación para instrumentos', '2024-02-01', '2024-05-31', 14, 14),
('Voluntarios en Acción', 'Reclutamiento de voluntarios', '2024-03-01', '2024-06-30', 15, 15),
('Alumbrado Solar', 'Campaña de energía renovable', '2024-04-01', '2024-07-31', 1, 16),
('Empleo Joven', 'Promoción de programa de empleo', '2025-01-01', '2025-03-31', 2, 17),
('Prevención de Incendios', 'Campaña educativa sobre incendios', '2025-02-01', '2025-05-31', 3, 18),
('Deporte para Todos', 'Promoción de espacios deportivos', '2025-03-01', '2025-06-30', 4, 19),
('Fotografía Social', 'Difusión de exposición fotográfica', '2025-04-01', '2025-07-31', 5, 20);
GO

-- Insertar Documentación (35 registros)
INSERT INTO Documentacion (nombreArchivo, tipoArchivo, url, fecha, Actividad_idActividad) VALUES
('Plan_Carrera_5K.pdf', 'PDF', 'https://docs.crowdfunding.sv/plan_carrera_5k.pdf', '2024-04-01', 1),
('Catalogo_Subasta_Arte.pdf', 'PDF', 'https://docs.crowdfunding.sv/catalogo_subasta.pdf', '2024-05-01', 2),
('Lineup_Concierto.pdf', 'PDF', 'https://docs.crowdfunding.sv/lineup_concierto.pdf', '2024-05-15', 3),
('Mapa_Reforestacion.pdf', 'PDF', 'https://docs.crowdfunding.sv/mapa_reforestacion.pdf', '2024-06-01', 4),
('Campaña_Sangre.jpg', 'Imagen', 'https://docs.crowdfunding.sv/campana_sangre.jpg', '2024-06-20', 5),
('Menu_Festival_Gastronomico.pdf', 'PDF', 'https://docs.crowdfunding.sv/menu_festival.pdf', '2024-07-01', 6),
('Programa_Talleres.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_talleres.pdf', '2024-07-20', 7),
('Lista_Utilies.pdf', 'PDF', 'https://docs.crowdfunding.sv/lista_utiles.pdf', '2024-08-01', 8),
('Catalogo_Mascotas.pdf', 'PDF', 'https://docs.crowdfunding.sv/catalogo_mascotas.pdf', '2024-08-20', 9),
('Planos_Biblioteca.pdf', 'PDF', 'https://docs.crowdfunding.sv/planos_biblioteca.pdf', '2024-09-01', 10),
('Invitacion_Gala.pdf', 'PDF', 'https://docs.crowdfunding.sv/invitacion_gala.pdf', '2024-09-15', 11),
('Catalogo_Artesanias.pdf', 'PDF', 'https://docs.crowdfunding.sv/catalogo_artesanias.pdf', '2024-10-01', 12),
('Guia_Salud.pdf', 'PDF', 'https://docs.crowdfunding.sv/guia_salud.pdf', '2024-10-15', 13),
('Programa_Concierto_Orquesta.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_orquesta.pdf', '2024-11-01', 14),
('Informe_Voluntariado.pdf', 'PDF', 'https://docs.crowdfunding.sv/informe_voluntariado.pdf', '2024-11-15', 15),
('Plan_Alumbrado.pdf', 'PDF', 'https://docs.crowdfunding.sv/plan_alumbrado.pdf', '2024-12-01', 16),
('Feria_Empleo_Folleto.pdf', 'PDF', 'https://docs.crowdfunding.sv/folleto_feria.pdf', '2025-01-01', 17),
('Manual_Prevencion.pdf', 'PDF', 'https://docs.crowdfunding.sv/manual_prevencion.pdf', '2025-02-01', 18),
('Torneo_Reglamento.pdf', 'PDF', 'https://docs.crowdfunding.sv/reglamento_torneo.pdf', '2025-03-01', 19),
('Exposicion_Catalogo.pdf', 'PDF', 'https://docs.crowdfunding.sv/catalogo_exposicion.pdf', '2025-04-01', 20),
('Plan_Alimentos.pdf', 'PDF', 'https://docs.crowdfunding.sv/plan_alimentos.pdf', '2025-05-01', 21),
('Hackathon_Bases.pdf', 'PDF', 'https://docs.crowdfunding.sv/bases_hackathon.pdf', '2025-06-01', 22),
('Festival_Programa.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_festival.pdf', '2025-07-01', 23),
('Carrera_Reglamento.pdf', 'PDF', 'https://docs.crowdfunding.sv/reglamento_carrera.pdf', '2025-08-01', 24),
('Subasta_Catalogo.pdf', 'PDF', 'https://docs.crowdfunding.sv/catalogo_subasta.pdf', '2025-09-01', 25),
('Congreso_Agenda.pdf', 'PDF', 'https://docs.crowdfunding.sv/agenda_congreso.pdf', '2025-10-01', 26),
('Campaña_Vacunacion.jpg', 'Imagen', 'https://docs.crowdfunding.sv/campana_vacunacion.jpg', '2025-11-01', 27),
('Desfile_Programa.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_desfile.pdf', '2025-12-01', 28),
('Limpieza_Playas_Plan.pdf', 'PDF', 'https://docs.crowdfunding.sv/plan_limpieza.pdf', '2024-05-01', 29),
('Festival_Cine_Programa.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_cine.pdf', '2024-06-01', 30),
('Carrera_Obstaculos_Reglamento.pdf', 'PDF', 'https://docs.crowdfunding.sv/reglamento_obstaculos.pdf', '2024-07-01', 31),
('Encuentro_Agenda.pdf', 'PDF', 'https://docs.crowdfunding.sv/agenda_encuentro.pdf', '2024-08-01', 32),
('Campaña_Dengue.pdf', 'PDF', 'https://docs.crowdfunding.sv/campana_dengue.pdf', '2024-09-01', 33),
('Concierto_Rock_Lineup.pdf', 'PDF', 'https://docs.crowdfunding.sv/lineup_rock.pdf', '2024-10-01', 34),
('Feria_Ciencias_Programa.pdf', 'PDF', 'https://docs.crowdfunding.sv/programa_ciencias.pdf', '2024-11-01', 35);
GO

-- Insertar MetaActividad (35 registros)
INSERT INTO MetaActividad (descripcion, fechaRealizacion, monto_meta, monto_actual, Actividad_idActividad) VALUES
('Meta de participantes', '2024-05-01', 500, 520, 1),
('Meta de recaudación', '2024-05-15', 15000, 18000, 2),
('Meta de asistentes', '2024-06-01', 8000, 10000, 3),
('Meta de árboles', '2024-06-30', 10000, 8500, 4),
('Meta de unidades de sangre', '2024-07-07', 500, 600, 5),
('Meta de recaudación', '2024-07-17', 8000, 9500, 6),
('Meta de capacitados', '2024-08-31', 200, 210, 7),
('Meta de útiles', '2024-09-15', 1000, 1200, 8),
('Meta de adopciones', '2024-09-01', 100, 100, 9),
('Meta de recaudación', '2024-10-15', 25000, 28000, 10),
('Meta de recaudación', '2024-10-01', 50000, 60000, 11),
('Meta de familias beneficiadas', '2024-10-31', 50, 55, 12),
('Meta de pruebas', '2024-11-30', 5000, 6000, 13),
('Meta de recaudación', '2024-12-15', 12000, 15000, 14),
('Meta de comunidades', '2024-12-20', 20, 25, 15),
('Meta de participantes', '2024-12-15', 4000, 5000, 16),
('Meta de colocados', '2025-01-16', 500, 600, 17),
('Meta de capacitados', '2025-02-28', 2000, 2500, 18),
('Meta de equipos', '2025-02-16', 40, 50, 19),
('Meta de visitantes', '2025-03-15', 4000, 5000, 20),
('Meta de toneladas', '2025-04-15', 5, 6, 21),
('Meta de soluciones', '2025-04-03', 10, 15, 22),
('Meta de comunidades', '2025-04-17', 15, 20, 23),
('Meta de ciclistas', '2025-05-01', 500, 800, 24),
('Meta de recaudación', '2025-05-15', 10000, 12000, 25),
('Meta de voluntarios', '2025-06-03', 1000, 1200, 26),
('Meta de mascotas', '2025-06-30', 2000, 2500, 27),
('Meta de diseñadores', '2025-07-01', 35, 40, 28),
('Meta de playas', '2025-07-15', 10, 10, 29),
('Meta de películas', '2025-08-07', 40, 50, 30),
('Meta de participantes', '2025-08-15', 600, 800, 31),
('Meta de emprendedores', '2025-09-02', 300, 400, 32),
('Meta de hogares', '2025-10-15', 5000, 6000, 33),
('Meta de asistentes', '2025-10-01', 12000, 15000, 34),
('Meta de niños', '2025-10-17', 1000, 1200, 35);
GO

-- Insertar Preguntas Frecuentes (35 registros)
INSERT INTO preguntas_Frecuentes (pregunta, respuesta, categoria, fecha_creacion, Actividad_idActividad) VALUES
('¿Cómo puedo hacer una donación?', 'Puede hacer una donación seleccionando un proyecto y eligiendo el monto. Aceptamos tarjetas de crédito, débito y otros métodos de pago.', 'Donaciones', '2024-01-01', 1),
('¿Las donaciones son deducibles de impuestos?', 'Sí, todas las donaciones son deducibles de impuestos. Recibirá un comprobante por correo electrónico.', 'Donaciones', '2024-01-01', 2),
('¿Puedo hacer una donación anónima?', 'Sí, al momento de donar puede seleccionar la opción de donación anónima.', 'Donaciones', '2024-01-01', 3),
('¿Cómo sé que mi donación llegó correctamente?', 'Recibirá una confirmación por correo electrónico y puede verificar en su historial de donaciones.', 'Donaciones', '2024-01-01', 4),
('¿Puedo solicitar un reembolso?', 'Los reembolsos se evalúan caso por caso. Contacte a nuestro equipo de soporte.', 'Donaciones', '2024-01-01', 5),
('¿Cómo puedo crear un proyecto?', 'Regístrese como creador y complete el formulario de solicitud de proyecto.', 'Proyectos', '2024-01-01', 6),
('¿Cuáles son los requisitos para un proyecto?', 'El proyecto debe tener un propósito social claro, metas definidas y presupuesto detallado.', 'Proyectos', '2024-01-01', 7),
('¿Cuánto tiempo tarda en aprobarse un proyecto?', 'La revisión toma entre 3 a 5 días hábiles.', 'Proyectos', '2024-01-01', 8),
('¿Puedo editar mi proyecto después de publicarlo?', 'Sí, puede hacer ediciones menores. Cambios mayores requieren aprobación.', 'Proyectos', '2024-01-01', 9),
('¿Qué pasa si no alcanzo mi meta?', 'Puede extender la campaña o ajustar las metas según lo recaudado.', 'Proyectos', '2024-01-01', 10),
('¿Cómo me registro como voluntario?', 'Complete el formulario de registro de voluntarios en la sección correspondiente.', 'Voluntariado', '2024-01-01', 11),
('¿Hay requisitos para ser voluntario?', 'Debe ser mayor de edad y completar la capacitación básica.', 'Voluntariado', '2024-01-01', 12),
('¿Puedo ser voluntario virtual?', 'Sí, tenemos oportunidades de voluntariado remoto.', 'Voluntariado', '2024-01-01', 13),
('¿Recibo algún certificado por voluntariado?', 'Sí, emitimos certificados de horas de voluntariado.', 'Voluntariado', '2024-01-01', 14),
('¿Cómo reporto un problema con un proyecto?', 'Use el formulario de reportes en la página del proyecto.', 'Reportes', '2024-01-01', 15),
('¿Qué métodos de pago aceptan?', 'Aceptamos tarjetas de crédito, débito, PayPal, transferencias y más.', 'Pagos', '2024-01-01', 16),
('¿Es seguro donar en esta plataforma?', 'Sí, utilizamos encriptación SSL y cumplimos con estándares de seguridad.', 'Seguridad', '2024-01-01', 17),
('¿Cómo contacto al creador de un proyecto?', 'Puede enviar un mensaje a través del foro del proyecto.', 'Comunicación', '2024-01-01', 18),
('¿Qué son las recompensas?', 'Los creadores pueden ofrecer recompensas a cambio de donaciones.', 'Recompensas', '2024-01-01', 19),
('¿Cómo recibo mi recompensa?', 'Las recompensas se entregan según lo especificado por el creador.', 'Recompensas', '2024-01-01', 20),
('¿Puedo donar desde otro país?', 'Sí, aceptamos donaciones internacionales.', 'Donaciones', '2024-01-01', 21),
('¿Cómo sé si un proyecto es legítimo?', 'Todos los proyectos pasan por un proceso de verificación.', 'Seguridad', '2024-01-01', 22),
('¿Puedo cancelar mi donación?', 'Las donaciones completadas no pueden cancelarse.', 'Donaciones', '2024-01-01', 23),
('¿Qué porcentaje se queda la plataforma?', 'La plataforma retiene un 5% para gastos administrativos.', 'Donaciones', '2024-01-01', 24),
('¿Cómo me convierto en patrocinador?', 'Contacte a nuestro equipo comercial para opciones de patrocinio.', 'Patrocinios', '2024-01-01', 25),
('¿Puedo hacer donaciones recurrentes?', 'Sí, puede configurar donaciones mensuales automáticas.', 'Donaciones', '2024-01-01', 26),
('¿Cómo funciona el foro?', 'El foro es un espacio para que donantes y creadores interactúen.', 'Comunicación', '2024-01-01', 27),
('¿Puedo compartir proyectos en redes sociales?', 'Sí, cada proyecto tiene botones para compartir.', 'Proyectos', '2024-01-01', 28),
('¿Cómo reporto contenido inapropiado?', 'Use el botón de reportar en el contenido o contacte soporte.', 'Reportes', '2024-01-01', 29),
('¿Ofrecen capacitaciones para creadores?', 'Sí, tenemos webinars y talleres gratuitos.', 'Proyectos', '2024-01-01', 30),
('¿Qué pasa si un proyecto es fraudulento?', 'Investigamos todos los reportes y tomamos acción inmediata.', 'Seguridad', '2024-01-01', 31),
('¿Cómo actualizo mis datos personales?', 'Puede editar su perfil en la sección de configuración.', 'Cuenta', '2024-01-01', 32),
('¿Puedo eliminar mi cuenta?', 'Sí, contacte a soporte para solicitar la eliminación.', 'Cuenta', '2024-01-01', 33),
('¿Cómo recibo notificaciones?', 'Configure sus preferencias de notificación en su perfil.', 'Cuenta', '2024-01-01', 34),
('¿Tienen aplicación móvil?', 'Estamos desarrollando nuestra app móvil. Próximamente.', 'General', '2024-01-01', 35);
GO

-- Insertar Presupuesto (35 registros)
INSERT INTO Presupuesto (descripcion_gastos, monto_Estimado, monto_Real, Proyecto_idProyecto) VALUES
('Becas escolares', 10000, 9500, 1),
('Renovación de instalaciones', 50000, 48000, 2),
('Ayuda a comunidades', 30000, 32000, 3),
('Compra de árboles y siembra', 20000, 18500, 4),
('Equipamiento médico', 15000, 15200, 5),
('Alimentos y utensilios', 8000, 7800, 6),
('Capacitación y materiales', 12000, 11500, 7),
('Útiles escolares', 15000, 14800, 8),
('Construcción de refugio', 25000, 26000, 9),
('Construcción de biblioteca', 40000, 38000, 10),
('Organización de evento', 20000, 22000, 11),
('Feria de artesanías', 5000, 4800, 12),
('Campaña de salud', 10000, 10500, 13),
('Compra de instrumentos', 12000, 11800, 14),
('Operaciones de voluntariado', 8000, 8200, 15),
('Luminarias solares', 18000, 17500, 16),
('Feria de empleo', 6000, 6200, 17),
('Capacitación y equipamiento', 8000, 7900, 18),
('Equipamiento deportivo', 6000, 5800, 19),
('Organización de exposición', 5000, 5100, 20),
('Recolección y distribución', 4000, 4200, 21),
('Organización de hackathon', 8000, 8500, 22),
('Festival cultural', 10000, 9800, 23),
('Organización de carrera', 7000, 7200, 24),
('Subasta y evento', 5000, 5300, 25),
('Organización de congreso', 15000, 14500, 26),
('Vacunas y medicinas', 8000, 8200, 27),
('Desfile de moda', 12000, 11800, 28),
('Limpieza de playas', 3000, 2900, 29),
('Festival de cine', 10000, 10500, 30),
('Organización de carrera', 20000, 19500, 31),
('Encuentro empresarial', 5000, 4800, 32),
('Campaña de fumigación', 10000, 10200, 33),
('Concierto de rock', 25000, 26000, 34),
('Feria de ciencias', 8000, 7900, 35);
GO

-- Insertar Foro (35 registros)
INSERT INTO Foro (nombreForo, descripcion, fecha_creacion, Actividad_idActividad) VALUES
('Foro Carrera 5K', 'Discusión sobre la carrera benéfica', '2024-04-01', 1),
('Foro Subasta de Arte', 'Comentarios sobre la subasta', '2024-05-01', 2),
('Foro Concierto por la Paz', 'Discusión sobre el concierto', '2024-05-15', 3),
('Foro Reforestación', 'Ideas para la reforestación', '2024-06-01', 4),
('Foro Donación de Sangre', 'Experiencias y preguntas', '2024-06-20', 5),
('Foro Festival Gastronómico', 'Reseñas de platillos', '2024-07-01', 6),
('Foro Emprendimiento', 'Consejos para emprendedores', '2024-07-20', 7),
('Foro Útiles Escolares', 'Lista de útiles necesarios', '2024-08-01', 8),
('Foro Adopción de Mascotas', 'Comparta historias de adopción', '2024-08-20', 9),
('Foro Biblioteca', 'Sugerencias de libros', '2024-09-01', 10),
('Foro Gala Anual', 'Expectativas del evento', '2024-09-15', 11),
('Foro Artesanías', 'Apreciación del arte local', '2024-10-01', 12),
('Foro Salud Preventiva', 'Consejos de salud', '2024-10-15', 13),
('Foro Orquesta', 'Música y cultura', '2024-11-01', 14),
('Foro Voluntariado', 'Experiencias de voluntarios', '2024-11-15', 15),
('Foro Alumbrado Solar', 'Beneficios de energía solar', '2024-12-01', 16),
('Foro Empleo Joven', 'Oportunidades laborales', '2025-01-01', 17),
('Foro Prevención', 'Seguridad ante incendios', '2025-02-01', 18),
('Foro Deporte', 'Actividades deportivas', '2025-03-01', 19),
('Foro Fotografía', 'Técnicas y exposiciones', '2025-04-01', 20),
('Foro Alimentos', 'Lucha contra el hambre', '2025-05-01', 21),
('Foro Tecnología', 'Innovación social', '2025-06-01', 22),
('Foro Cultura', 'Tradiciones indígenas', '2025-07-01', 23),
('Foro Ciclismo', 'Rutas y eventos', '2025-08-01', 24),
('Foro Parques', 'Espacios públicos', '2025-09-01', 25),
('Foro Congreso', 'Experiencias del congreso', '2025-10-01', 26),
('Foro Mascotas', 'Cuidado animal', '2025-11-01', 27),
('Foro Moda', 'Diseño y creatividad', '2025-12-01', 28),
('Foro Playas', 'Conservación marina', '2024-05-01', 29),
('Foro Cine', 'Películas independientes', '2024-06-01', 30),
('Foro Carrera Extrema', 'Desafíos deportivos', '2024-07-01', 31),
('Foro Emprendedores', 'Networking empresarial', '2024-08-01', 32),
('Foro Dengue', 'Prevención de enfermedades', '2024-09-01', 33),
('Foro Rock', 'Música y solidaridad', '2024-10-01', 34),
('Foro Ciencias', 'Educación STEM', '2024-11-01', 35);
GO

PRINT 'Datos adicionales insertados exitosamente.';
GO

-- Insertar Capacitaciones (35 registros)
INSERT INTO Capacitacion (titulo_Capacitacion, descripcion, fecha_inicio, fecha_fin, usuario_idUsuario, Administrador_idAdministrador) VALUES
('Gestión de Proyectos Sociales', 'Curso sobre planificación y ejecución de proyectos', '2024-01-15', '2024-02-15', 1, 1),
('Marketing Digital para Causas', 'Estrategias de marketing para proyectos benéficos', '2024-02-01', '2024-03-01', 2, 2),
('Finanzas para ONG', 'Gestión financiera de organizaciones sin fines de lucro', '2024-03-01', '2024-04-01', 3, 3),
('Comunicación Efectiva', 'Técnicas de comunicación con donantes', '2024-04-01', '2024-05-01', 4, 4),
('Uso de la Plataforma', 'Guía completa de uso de la plataforma', '2024-05-01', '2024-05-15', 5, 5),
('Redacción de Proyectos', 'Cómo redactar proyectos atractivos', '2024-06-01', '2024-06-30', 6, 6),
('Fotografía para Causas', 'Fotografía que inspira donaciones', '2024-07-01', '2024-07-31', 7, 7),
('Video Storytelling', 'Creación de videos impactantes', '2024-08-01', '2024-08-31', 8, 8),
('Redes Sociales', 'Estrategia en redes sociales', '2024-09-01', '2024-09-30', 9, 9),
('Atención al Donante', 'Cómo fidelizar donantes', '2024-10-01', '2024-10-31', 10, 10),
('Ética en Crowdfunding', 'Mejores prácticas éticas', '2024-11-01', '2024-11-30', 11, 11),
('Métricas y Análisis', 'Análisis de resultados', '2024-12-01', '2024-12-31', 12, 12),
('Voluntariado Efectivo', 'Gestión de voluntarios', '2025-01-01', '2025-01-31', 13, 13),
('Eventos Benéficos', 'Organización de eventos', '2025-02-01', '2025-02-28', 14, 14),
('Captación de Fondos', 'Técnicas de fundraising', '2025-03-01', '2025-03-31', 15, 15),
('Sostenibilidad', 'Proyectos sostenibles', '2025-04-01', '2025-04-30', 16, 1),
('Impacto Social', 'Medición de impacto', '2025-05-01', '2025-05-31', 17, 2),
('Alianzas Estratégicas', 'Construcción de alianzas', '2025-06-01', '2025-06-30', 18, 3),
('Transparencia', 'Reportes transparentes', '2025-07-01', '2025-07-31', 19, 4),
('Innovación Social', 'Nuevas tendencias', '2025-08-01', '2025-08-31', 20, 5),
('Liderazgo', 'Liderazgo en causas sociales', '2025-09-01', '2025-09-30', 21, 6),
('Trabajo en Equipo', 'Equipos de alto rendimiento', '2025-10-01', '2025-10-31', 22, 7),
('Resolución de Conflictos', 'Manejo de situaciones difíciles', '2025-11-01', '2025-11-30', 23, 8),
('Diversidad e Inclusión', 'Proyectos inclusivos', '2025-12-01', '2025-12-31', 24, 9),
('Sostenibilidad Ambiental', 'Proyectos verdes', '2024-01-15', '2024-02-15', 25, 10),
('Tecnología Social', 'Uso de tech para el bien', '2024-03-01', '2024-04-01', 26, 11),
('Comunicación Crisis', 'Manejo de crisis', '2024-05-01', '2024-06-01', 27, 12),
('Legislación', 'Marco legal para ONG', '2024-07-01', '2024-08-01', 28, 13),
('Gestión de Riesgos', 'Identificación y mitigación', '2024-09-01', '2024-10-01', 29, 14),
('Sostenibilidad Financiera', 'Modelos de ingreso', '2024-11-01', '2024-12-01', 30, 15),
('Empoderamiento', 'Empoderamiento comunitario', '2025-01-15', '2025-02-15', 31, 1),
('Colaboración', 'Trabajo colaborativo', '2025-03-01', '2025-04-01', 32, 2),
('Creatividad', 'Pensamiento creativo', '2025-05-01', '2025-06-01', 33, 3),
('Resiliencia', 'Capacidad de adaptación', '2025-07-01', '2025-08-01', 34, 4),
('Visión de Futuro', 'Planificación estratégica', '2025-09-01', '2025-10-01', 35, 5);
GO

-- Insertar Recompensas (35 registros)
INSERT INTO Recompensa (nombre, descripcion, monto_minimo, fecha_Entrega, TipoRecompensa_idTipoRecompensa, Proyecto_idProyecto) VALUES
('Agradecimiento Digital', 'Mención en redes sociales', 10.00, '2024-06-01', 1, 1),
('Mención Especial', 'Tu nombre en la página del proyecto', 25.00, '2024-06-15', 2, 1),
('Certificado Digital', 'Certificado de agradecimiento', 50.00, '2024-07-01', 10, 1),
('Tote Bag Edición Especial', 'Bolso con diseño del proyecto', 75.00, '2024-07-15', 3, 2),
('Camiseta Solidaria', 'Camiseta conmemorativa', 100.00, '2024-08-01', 9, 2),
('Gorra del Proyecto', 'Gorra con logo bordado', 50.00, '2024-08-15', 9, 2),
('Mug Personalizado', 'Taza con diseño exclusivo', 30.00, '2024-09-01', 3, 3),
('Sticker Pack', 'Set de stickers del proyecto', 15.00, '2024-09-15', 3, 3),
('Postal Firmada', 'Postal con mensaje de agradecimiento', 20.00, '2024-10-01', 3, 4),
('Llavero Conmemorativo', 'Llavero edición limitada', 25.00, '2024-10-15', 3, 4),
('Poster del Evento', 'Póster firmado por el equipo', 40.00, '2024-11-01', 3, 5),
('Botella Reutilizable', 'Botella ecológica con logo', 35.00, '2024-11-15', 3, 5),
('Cuaderno Solidario', 'Cuaderno con diseño exclusivo', 45.00, '2024-12-01', 3, 6),
('Bolsa Ecológica', 'Bolsa de tela reutilizable', 30.00, '2024-12-15', 3, 6),
('Pin Coleccionable', 'Pin metálico edición limitada', 20.00, '2025-01-01', 3, 7),
('Libreta de Notas', 'Libreta con portada personalizada', 40.00, '2025-01-15', 3, 7),
('Calendario Solidario', 'Calendario con fotos del proyecto', 50.00, '2025-02-01', 3, 8),
('Marcador de Libros', 'Marcador metálico grabado', 25.00, '2025-02-15', 3, 8),
('Fotografía Firmada', 'Fotografía del proyecto firmada', 100.00, '2025-03-01', 3, 9),
('Videollamada con Equipo', 'Sesión de 30 min con el equipo', 200.00, '2025-03-15', 11, 9),
('Cena con Fundadores', 'Cena exclusiva con los fundadores', 500.00, '2025-04-01', 12, 10),
('Experiencia VIP', 'Acceso exclusivo a eventos', 300.00, '2025-04-15', 4, 10),
('Reconocimiento Público', 'Mención en evento de gala', 150.00, '2025-05-01', 5, 11),
('Descuento en Productos', '20% de descuento por un año', 100.00, '2025-05-15', 6, 11),
('Acceso Anticipado', 'Acceso exclusivo a novedades', 75.00, '2025-06-01', 7, 12),
('Contenido Exclusivo', 'Videos y material exclusivo', 50.00, '2025-06-15', 8, 12),
('Merchandising Premium', 'Pack completo de productos', 250.00, '2025-07-01', 9, 13),
('Taller Exclusivo', 'Acceso a taller privado', 150.00, '2025-07-15', 12, 13),
('Suscripción Gratuita', 'Un año de suscripción', 200.00, '2025-08-01', 13, 14),
('Sorteo Especial', 'Participación en sorteo exclusivo', 75.00, '2025-08-15', 14, 14),
('Recompensa Personalizada', 'Recompensa adaptada a ti', 500.00, '2025-09-01', 15, 15),
('Árbol con tu Nombre', 'Árbol plantado a tu nombre', 100.00, '2025-09-15', 2, 16),
('Placa Conmemorativa', 'Placa en el proyecto', 1000.00, '2025-10-01', 5, 16),
('Pase Anual', 'Acceso ilimitado por un año', 400.00, '2025-10-15', 7, 17),
('Kit de Bienvenida', 'Pack de bienvenida exclusivo', 150.00, '2025-11-01', 3, 17);
GO

-- Insertar Certificados (35 registros)
INSERT INTO Certificado (tipo_certificado, fecha_entrega, Proyecto_idProyecto) VALUES
('Financiamiento', '2024-12-31', 1),
('Participación', '2024-08-31', 2),
('Financiamiento', '2024-09-30', 3),
('Participación', '2024-12-31', 4),
('Financiamiento', '2024-07-15', 5),
('Participación', '2024-12-31', 6),
('Financiamiento', '2024-09-15', 7),
('Participación', '2024-10-15', 8),
('Financiamiento', '2024-11-30', 9),
('Participación', '2025-06-01', 10),
('Financiamiento', '2024-10-01', 11),
('Participación', '2024-12-31', 12),
('Financiamiento', '2024-12-31', 13),
('Participación', '2024-08-31', 14),
('Financiamiento', '2024-12-31', 15),
('Participación', '2024-10-31', 16),
('Financiamiento', '2025-12-31', 17),
('Participación', '2025-08-31', 18),
('Financiamiento', '2025-09-30', 19),
('Participación', '2025-10-31', 20),
('Financiamiento', '2025-11-30', 21),
('Participación', '2025-12-31', 22),
('Financiamiento', '2025-12-31', 23),
('Participación', '2025-12-31', 24),
('Financiamiento', '2025-12-31', 25),
('Participación', '2025-12-31', 26),
('Financiamiento', '2025-12-31', 27),
('Participación', '2025-12-31', 28),
('Financiamiento', '2024-12-31', 29),
('Participación', '2024-12-31', 30),
('Financiamiento', '2024-12-31', 31),
('Participación', '2025-12-31', 32),
('Financiamiento', '2025-12-31', 33),
('Participación', '2025-12-31', 34),
('Financiamiento', '2025-12-31', 35);
GO

-- Insertar Historial_Actividades (35 registros)
INSERT INTO Historial_Actividades (Creador_idCreador, Actividad_idActividad, fecha_inicio, fecha_fin, descripcion) VALUES
(1, 1, '2023-05-01', '2023-05-01', 'Primera edición de la carrera 5K'),
(2, 2, '2023-05-15', '2023-05-15', 'Subasta de arte del año pasado'),
(3, 3, '2023-06-01', '2023-06-01', 'Concierto benéfico anterior'),
(4, 4, '2023-06-15', '2023-06-30', 'Campaña de reforestación 2023'),
(5, 5, '2023-07-01', '2023-07-07', 'Maratón de sangre anterior'),
(6, 6, '2023-07-15', '2023-07-17', 'Festival gastronómico 2023'),
(7, 7, '2023-08-01', '2023-08-31', 'Talleres de emprendimiento 2023'),
(8, 8, '2023-08-15', '2023-09-15', 'Campaña de útiles 2023'),
(9, 9, '2023-09-01', '2023-09-01', 'Evento de adopción anterior'),
(10, 10, '2023-09-15', '2023-10-15', 'Recaudación para biblioteca 2023'),
(11, 11, '2023-10-01', '2023-10-01', 'Cena de gala 2023'),
(12, 12, '2023-10-15', '2023-10-31', 'Feria de artesanías 2023'),
(13, 13, '2023-11-01', '2023-11-30', 'Campaña de diabetes 2023'),
(14, 14, '2023-11-15', '2023-12-15', 'Recaudación para orquesta 2023'),
(15, 15, '2023-12-01', '2023-12-20', 'Voluntariado 2023'),
(16, 16, '2023-12-15', '2023-12-15', 'Carrera nocturna 2023'),
(17, 17, '2024-01-15', '2024-01-16', 'Feria de empleo 2024'),
(18, 18, '2024-02-01', '2024-02-28', 'Capacitación en incendios 2024'),
(19, 19, '2024-02-15', '2024-02-16', 'Torneo deportivo 2024'),
(20, 20, '2024-03-01', '2024-03-15', 'Exposición fotográfica 2024'),
(21, 21, '2024-03-15', '2024-04-15', 'Campaña de alimentos 2024'),
(22, 22, '2024-04-01', '2024-04-03', 'Hackathon 2024'),
(23, 23, '2024-04-15', '2024-04-17', 'Festival cultural 2024'),
(24, 24, '2024-05-01', '2024-05-01', 'Carrera ciclística 2024'),
(25, 25, '2024-05-15', '2024-05-15', 'Subasta silent 2024'),
(26, 26, '2024-06-01', '2024-06-03', 'Congreso de voluntariado 2024'),
(27, 27, '2024-06-15', '2024-06-30', 'Campaña de vacunación 2024'),
(28, 28, '2024-07-01', '2024-07-01', 'Desfile de moda 2024'),
(29, 29, '2024-07-15', '2024-07-15', 'Limpieza de playas 2024'),
(30, 30, '2024-08-01', '2024-08-07', 'Festival de cine 2024'),
(1, 31, '2024-08-15', '2024-08-15', 'Carrera de obstáculos 2024'),
(2, 32, '2024-09-01', '2024-09-02', 'Encuentro de emprendedores 2024'),
(3, 33, '2024-09-15', '2024-10-15', 'Campaña contra el dengue 2024'),
(4, 34, '2024-10-01', '2024-10-01', 'Concierto de rock 2024'),
(5, 35, '2024-10-15', '2024-10-17', 'Feria de ciencias 2024');
GO

-- Insertar Sanciones (20 registros)
INSERT INTO Sancion (motivo, fecha_sancion, tipo_sancion, Administrador_idAdministrador) VALUES
('Publicación de contenido falso', '2024-01-15', 'Advertencia', 1),
('Comportamiento inapropiado en foro', '2024-02-01', 'Suspensión Temporal', 2),
('Fraude en proyecto', '2024-02-20', 'Suspensión Permanente', 3),
('Spam reiterado', '2024-03-10', 'Advertencia', 4),
('Acoso a otros usuarios', '2024-03-25', 'Suspensión Temporal', 5),
('Uso de múltiples cuentas', '2024-04-05', 'Suspensión Temporal', 6),
('Plagio de contenido', '2024-04-20', 'Advertencia', 7),
('Incumplimiento de normas', '2024-05-01', 'Advertencia', 8),
('Publicidad engañosa', '2024-05-15', 'Suspensión Temporal', 9),
('Discriminación', '2024-06-01', 'Suspensión Permanente', 10),
('Intento de hacking', '2024-06-15', 'Suspensión Permanente', 11),
('Difamación', '2024-07-01', 'Advertencia', 12),
('Violación de privacidad', '2024-07-20', 'Suspensión Temporal', 13),
('Suplantación de identidad', '2024-08-05', 'Suspensión Permanente', 14),
('Amenazas', '2024-08-25', 'Suspensión Permanente', 15),
('Contenido ilegal', '2024-09-10', 'Suspensión Permanente', 1),
('Evación de sanciones', '2024-09-25', 'Suspensión Permanente', 2),
('Manipulación de votos', '2024-10-10', 'Suspensión Temporal', 3),
('Incitación al odio', '2024-10-25', 'Suspensión Permanente', 4),
('Venta de productos no autorizados', '2024-11-10', 'Advertencia', 5);
GO

-- Insertar Mensajes (35 registros)
INSERT INTO Mensaje (ContenidoMensaje, usuario_idUsuario, fecha_envio) VALUES
('Hola, quiero información sobre cómo donar', 1, '2024-01-20 10:00:00'),
('Gracias por su donación, recibirá un comprobante', 2, '2024-01-21 09:30:00'),
('¿Cuándo se entregarán las recompensas?', 3, '2024-02-05 14:20:00'),
('Las recompensas se entregarán en julio', 4, '2024-02-06 11:15:00'),
('Me encanta este proyecto, felicidades', 5, '2024-02-10 16:45:00'),
('Gracias por su apoyo, significa mucho', 6, '2024-02-11 08:00:00'),
('¿Puedo cambiar el monto de mi donación?', 7, '2024-02-15 13:30:00'),
('Por favor contacte a soporte para cambios', 8, '2024-02-16 10:45:00'),
('Excelente iniciativa, compartiré con amigos', 9, '2024-02-20 17:00:00'),
('Gracias por compartir, cada donación cuenta', 10, '2024-02-21 09:00:00'),
('¿El proyecto acepta donaciones internacionales?', 11, '2024-03-05 12:30:00'),
('Sí, aceptamos donaciones de todo el mundo', 12, '2024-03-06 14:00:00'),
('Quiero ser voluntario, ¿cómo me registro?', 13, '2024-03-10 11:20:00'),
('Puede registrarse en la sección de voluntarios', 14, '2024-03-11 15:30:00'),
('El evento fue increíble, gracias por organizarlo', 15, '2024-03-15 18:00:00'),
('Nos alegra que haya disfrutado el evento', 16, '2024-03-16 10:00:00'),
('¿Cuándo será la próxima carrera?', 17, '2024-03-20 09:45:00'),
('La próxima carrera será en diciembre', 18, '2024-03-21 13:15:00'),
('Mi recompensa llegó en perfectas condiciones', 19, '2024-04-01 16:30:00'),
('Nos alegra que haya recibido su recompensa', 20, '2024-04-02 11:00:00'),
('¿Puedo donar en nombre de alguien más?', 21, '2024-04-05 10:20:00'),
('Sí, puede hacer donaciones dedicadas', 22, '2024-04-06 14:45:00'),
('El proyecto está muy bien organizado', 23, '2024-04-10 17:30:00'),
('Gracias por su comentario positivo', 24, '2024-04-11 09:15:00'),
('¿Cómo puedo contactar al creador?', 25, '2024-04-15 12:00:00'),
('Puede usar el foro del proyecto', 26, '2024-04-16 15:45:00'),
('Quiero patrocinar este proyecto', 27, '2024-04-20 11:30:00'),
('Excelente, contacte a nuestro equipo comercial', 28, '2024-04-21 10:00:00'),
('La transparencia de este proyecto es admirable', 29, '2024-05-01 16:00:00'),
('Nos esforzamos por ser transparentes', 30, '2024-05-02 09:30:00'),
('¿Puedo visitar el proyecto personalmente?', 31, '2024-05-05 13:00:00'),
('Sí, coordine una visita con el creador', 32, '2024-05-06 14:30:00'),
('Mi familia y yo donamos juntos', 33, '2024-05-10 17:15:00'),
('Qué hermoso gesto familiar, gracias', 34, '2024-05-11 11:45:00'),
('Este proyecto ha cambiado vidas', 35, '2024-05-15 15:00:00');
GO

PRINT 'Datos finales insertados exitosamente.';
GO

-- Insertar Conversaciones (20 registros)
INSERT INTO Conversacion (fechaConversacion, asunto) VALUES
('2024-01-20 10:00:00', 'Consulta sobre donación'),
('2024-01-25 14:30:00', 'Información de proyecto'),
('2024-02-01 09:00:00', 'Soporte técnico'),
('2024-02-10 16:00:00', 'Reclamo de recompensa'),
('2024-02-20 11:00:00', 'Consulta general'),
('2024-03-01 13:30:00', 'Registro de voluntario'),
('2024-03-15 15:00:00', 'Feedback de evento'),
('2024-03-25 10:30:00', 'Pregunta sobre reembolso'),
('2024-04-05 14:00:00', 'Interés en patrocinio'),
('2024-04-15 11:30:00', 'Reporte de problema'),
('2024-05-01 16:30:00', 'Felicitaciones'),
('2024-05-15 09:30:00', 'Consulta de recompensa'),
('2024-06-01 12:00:00', 'Solicitud de información'),
('2024-06-15 17:00:00', 'Queja formal'),
('2024-07-01 10:00:00', 'Propuesta de colaboración'),
('2024-07-15 14:30:00', 'Consulta sobre impuestos'),
('2024-08-01 11:00:00', 'Sugerencia de mejora'),
('2024-08-15 15:30:00', 'Agradecimiento'),
('2024-09-01 09:00:00', 'Pregunta frecuente'),
('2024-09-15 16:00:00', 'Seguimiento de caso');
GO

-- Insertar Mensajería (35 registros)
INSERT INTO Mensajeria (Mensaje_idMensaje, Conversacion_idConversacion, Estado, fecha_recepcion) VALUES
(1, 1, 'Leído', '2024-01-20 10:05:00'),
(2, 1, 'Leído', '2024-01-21 09:35:00'),
(3, 2, 'Leído', '2024-02-05 14:25:00'),
(4, 2, 'Leído', '2024-02-06 11:20:00'),
(5, 3, 'Leído', '2024-02-10 16:50:00'),
(6, 3, 'Leído', '2024-02-11 08:05:00'),
(7, 4, 'Leído', '2024-02-15 13:35:00'),
(8, 4, 'Leído', '2024-02-16 10:50:00'),
(9, 5, 'Leído', '2024-02-20 17:05:00'),
(10, 5, 'Leído', '2024-02-21 09:05:00'),
(11, 6, 'Leído', '2024-03-05 12:35:00'),
(12, 6, 'Leído', '2024-03-06 14:05:00'),
(13, 7, 'Leído', '2024-03-10 11:25:00'),
(14, 7, 'Leído', '2024-03-11 15:35:00'),
(15, 8, 'Leído', '2024-03-15 18:05:00'),
(16, 8, 'Leído', '2024-03-16 10:05:00'),
(17, 9, 'Leído', '2024-03-20 09:50:00'),
(18, 9, 'Leído', '2024-03-21 13:20:00'),
(19, 10, 'Leído', '2024-04-01 16:35:00'),
(20, 10, 'Leído', '2024-04-02 11:05:00'),
(21, 11, 'Pendiente', NULL),
(22, 11, 'Pendiente', NULL),
(23, 12, 'Leído', '2024-04-10 17:35:00'),
(24, 12, 'Leído', '2024-04-11 09:20:00'),
(25, 13, 'Leído', '2024-04-15 12:05:00'),
(26, 13, 'Leído', '2024-04-16 15:50:00'),
(27, 14, 'Pendiente', NULL),
(28, 14, 'Pendiente', NULL),
(29, 15, 'Leído', '2024-05-01 16:05:00'),
(30, 15, 'Leído', '2024-05-02 09:35:00'),
(31, 16, 'Leído', '2024-05-05 13:05:00'),
(32, 16, 'Leído', '2024-05-06 14:35:00'),
(33, 17, 'Leído', '2024-05-10 17:20:00'),
(34, 17, 'Leído', '2024-05-11 11:50:00'),
(35, 18, 'Pendiente', NULL);
GO

-- Insertar Notificaciones (35 registros)
INSERT INTO Notificacion (usuario_idUsuario, descripcion, titulo, referencia, fecha_envio, leida) VALUES
(1, 'Su donación ha sido procesada exitosamente', 'Donación Confirmada', 'Donacion-001', '2024-01-20 10:05:00', 1),
(2, 'Nueva actualización en el proyecto que apoya', 'Actualización de Proyecto', 'Proyecto-001', '2024-01-22 09:00:00', 1),
(3, 'Su recompensa está en camino', 'Recompensa Enviada', 'Recompensa-005', '2024-03-01 14:00:00', 0),
(4, 'Nuevo mensaje en el foro', 'Mensaje en Foro', 'Foro-003', '2024-02-05 16:00:00', 1),
(5, 'El proyecto alcanzó el 50% de su meta', 'Meta Alcanzada', 'Proyecto-003', '2024-02-10 11:00:00', 1),
(6, 'Recordatorio: Evento próximo', 'Recordatorio de Evento', 'Actividad-006', '2024-07-10 09:00:00', 0),
(7, 'Su reporte ha sido atendido', 'Reporte Resuelto', 'Reporte-007', '2024-03-20 15:00:00', 1),
(8, 'Nuevo proyecto de su interés', 'Proyecto Recomendado', 'Proyecto-008', '2024-04-01 10:00:00', 0),
(9, 'Su certificado está disponible', 'Certificado Listo', 'Certificado-009', '2024-09-05 12:00:00', 1),
(10, 'Gracias por ser donante recurrente', 'Agradecimiento', 'Donante-010', '2024-05-01 08:00:00', 1),
(11, 'Nueva recompensa disponible', 'Nueva Recompensa', 'Recompensa-011', '2024-06-15 14:00:00', 0),
(12, 'El proyecto que apoya finalizó exitosamente', 'Proyecto Completado', 'Proyecto-012', '2024-11-01 16:00:00', 1),
(13, 'Invitación a evento exclusivo', 'Invitación Especial', 'Evento-013', '2024-10-20 11:00:00', 0),
(14, 'Su capacitación inicia pronto', 'Recordatorio Capacitación', 'Capacitacion-014', '2024-08-25 09:00:00', 1),
(15, 'Nueva noticia sobre su proyecto', 'Noticia Nueva', 'Noticia-015', '2024-12-01 13:00:00', 0),
(16, 'Su pago ha sido confirmado', 'Pago Confirmado', 'Pago-016', '2024-04-01 10:05:00', 1),
(17, 'Actualización de políticas', 'Aviso Importante', 'General', '2024-05-15 08:00:00', 1),
(18, 'Felicitaciones en su cumpleaños', 'Feliz Cumpleaños', 'Personal', '2024-06-20 00:00:00', 1),
(19, 'Nueva funcionalidad disponible', 'Actualización de Plataforma', 'Sistema', '2024-07-01 10:00:00', 0),
(20, 'Su reembolso ha sido procesado', 'Reembolso Procesado', 'Reembolso-020', '2024-08-10 14:00:00', 1),
(21, 'Nueva actividad cerca de usted', 'Actividad Local', 'Actividad-021', '2024-09-01 11:00:00', 0),
(22, 'Su proyecto ha sido aprobado', 'Proyecto Aprobado', 'Proyecto-022', '2024-10-05 16:00:00', 1),
(23, 'Recordatorio de documentos pendientes', 'Documentos Pendientes', 'Documentacion-023', '2024-11-10 09:00:00', 0),
(24, 'Su revisión ha sido publicada', 'Reseña Publicada', 'Reseña-024', '2024-12-05 13:00:00', 1),
(25, 'Nuevo seguidor en su proyecto', 'Nuevo Seguidor', 'Social-025', '2025-01-01 10:00:00', 0),
(26, 'Meta extendida exitosamente', 'Meta Extendida', 'Proyecto-026', '2025-02-01 15:00:00', 1),
(27, 'Invitación a encuesta', 'Tu Opinión Importa', 'Encuesta-027', '2025-03-01 11:00:00', 0),
(28, 'Su patrocinio ha sido confirmado', 'Patrocinio Confirmado', 'Patrocinio-028', '2025-04-01 14:00:00', 1),
(29, 'Nuevo comentario en su proyecto', 'Nuevo Comentario', 'Foro-029', '2025-05-01 09:00:00', 0),
(30, 'Reporte mensual disponible', 'Reporte Mensual', 'Reporte-030', '2025-06-01 12:00:00', 1),
(31, 'Su sanción ha sido levantada', 'Sanción Levantada', 'Sancion-031', '2025-07-01 10:00:00', 1),
(32, 'Nueva insignia obtenida', 'Insignia Desbloqueada', 'Gamificacion-032', '2025-08-01 16:00:00', 0),
(33, 'Invitación a webinar', 'Webinar Gratuito', 'Capacitacion-033', '2025-09-01 11:00:00', 0),
(34, 'Su donación recurrente fue procesada', 'Donación Recurrente', 'Donacion-034', '2025-10-01 08:00:00', 1),
(35, 'Año nuevo, nuevas metas', 'Feliz Año Nuevo', 'General', '2025-01-01 00:00:00', 1);
GO

PRINT 'Todos los datos de prueba han sido insertados exitosamente.';
PRINT '';
PRINT '==============================================================';
PRINT 'RESUMEN DE TABLAS Y REGISTROS INSERTADOS';
PRINT '==============================================================';
PRINT '';
PRINT 'TABLAS CATÁLOGO (Datos de referencia - mínimo 15 registros cada una):';
PRINT '  - Tipo_Actividad: 15 registros';
PRINT '  - Forma_Pago: 15 registros';
PRINT '  - Comprobante: 15 registros';
PRINT '  - TipoRecompensa: 15 registros';
PRINT '  - Patrocinador: 15 registros';
PRINT '';
PRINT 'TABLAS TRANSACCIONALES (Registros operativos - mínimo 30 registros cada una):';
PRINT '  - usuario: 35 registros';
PRINT '  - Creador: 30 registros';
PRINT '  - Administrador: 15 registros';
PRINT '  - Telefono: 35 registros';
PRINT '  - Actividad: 35 registros';
PRINT '  - Donante: 35 registros';
PRINT '  - Proyecto: 35 registros';
PRINT '  - Donacion: 40 registros';
PRINT '  - Beneficiario: 35 registros';
PRINT '  - Pago: 35 registros';
PRINT '  - Reporte: 35 registros';
PRINT '  - Reseña: 35 registros';
PRINT '  - Movimiento: 35 registros';
PRINT '  - DetalleComprobante: 35 registros';
PRINT '  - reembolso: 20 registros';
PRINT '  - Noticia: 35 registros';
PRINT '  - Marketing: 20 registros';
PRINT '  - Documentacion: 35 registros';
PRINT '  - MetaActividad: 35 registros';
PRINT '  - preguntas_Frecuentes: 35 registros';
PRINT '  - Presupuesto: 35 registros';
PRINT '  - Foro: 35 registros';
PRINT '  - Capacitacion: 35 registros';
PRINT '  - Recompensa: 35 registros';
PRINT '  - Certificado: 35 registros';
PRINT '  - Historial_Actividades: 35 registros';
PRINT '  - Sancion: 20 registros';
PRINT '  - Mensaje: 35 registros';
PRINT '  - Conversacion: 20 registros';
PRINT '  - Mensajeria: 35 registros';
PRINT '  - Notificacion: 35 registros';
PRINT '';
PRINT '==============================================================';
GO

-- =====================================================
-- 6. CREACIÓN DE VISTAS
-- =====================================================

-- -----------------------------------------------------
-- VISTA 1: vw_LandingPage (Inicio - Landing Page)
-- Muestra información resumida para la página principal
-- -----------------------------------------------------
CREATE VIEW vw_LandingPage AS
SELECT 
    (SELECT COUNT(*) FROM Proyecto WHERE estado = 'Activo') AS TotalProyectosActivos,
    (SELECT COUNT(*) FROM Donacion) AS TotalDonaciones,
    (SELECT ISNULL(SUM(monto), 0) FROM Donacion) AS MontoTotalRecaudado,
    (SELECT COUNT(*) FROM usuario) AS TotalUsuariosRegistrados,
    (SELECT COUNT(*) FROM Creador WHERE estado = 'Activo') AS TotalCreadoresActivos,
    (SELECT COUNT(*) FROM Actividad WHERE fecha_fin >= GETDATE()) AS ActividadesEnCurso,
    (SELECT TOP 1 nombre_Proyecto FROM Proyecto WHERE estado = 'Activo' ORDER BY idProyecto DESC) AS ProyectoDestacado,
    (SELECT ISNULL(SUM(monto), 0) FROM Donacion WHERE fecha >= DATEADD(day, -30, GETDATE())) AS RecaudacionUltimoMes;
GO

-- -----------------------------------------------------
-- VISTA 2: vw_Actividades
-- Muestra información detallada de actividades
-- -----------------------------------------------------
CREATE VIEW vw_Actividades AS
SELECT 
    a.idActividad,
    a.nom_actividad AS NombreActividad,
    a.fecha_inicio AS FechaInicio,
    a.fecha_fin AS FechaFin,
    a.meta AS MetaActividad,
    ta.nom AS TipoActividad,
    p.nom_patro AS Patrocinador,
    (SELECT COUNT(*) FROM Beneficiario WHERE Actividad_idActividad = a.idActividad) AS TotalBeneficiarios,
    (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) AS TotalReseñas,
    (SELECT COUNT(*) FROM Noticia WHERE Actividad_idActividad = a.idActividad) AS TotalNoticias,
    CASE 
        WHEN a.fecha_fin < GETDATE() THEN 'Finalizada'
        WHEN a.fecha_inicio <= GETDATE() AND a.fecha_fin >= GETDATE() THEN 'En Curso'
        ELSE 'Pendiente'
    END AS EstadoActividad
FROM Actividad a
INNER JOIN Tipo_Actividad ta ON a.Tipo_Actividad_idTipo_Actividad = ta.idTipo_Actividad
INNER JOIN Patrocinador p ON a.Patrocinador_idPatrocinador = p.idPatrocinador;
GO

-- -----------------------------------------------------
-- VISTA 3: vw_Donaciones
-- Muestra información detallada de donaciones
-- -----------------------------------------------------
CREATE VIEW vw_Donaciones AS
SELECT 
    d.idDonacion,
    d.monto AS MontoDonacion,
    d.anonima AS EsAnonima,
    d.mensaje AS MensajeDonacion,
    d.fecha AS FechaDonacion,
    u.Pnom + ' ' + u.Pappe AS NombreDonante,
    u.correo AS CorreoDonante,
    p.nombre_Proyecto AS ProyectoBeneficiado,
    p.estado AS EstadoProyecto,
    c.nom_creador AS CreadorProyecto,
    CASE 
        WHEN pa.idPago IS NOT NULL THEN 'Pagada'
        ELSE 'Pendiente de Pago'
    END AS EstadoPago,
    pa.referencia AS ReferenciaPago
FROM Donacion d
INNER JOIN usuario u ON d.Usuario_idUsuario = u.idUsuario
INNER JOIN Proyecto p ON d.Proyecto_idProyecto = p.idProyecto
INNER JOIN Creador c ON p.Creador_idCreador = c.idCreador
LEFT JOIN Pago pa ON pa.Donacion_idDonacion = d.idDonacion;
GO

-- -----------------------------------------------------
-- VISTA 4: vw_Noticias
-- Muestra información de noticias con detalles
-- -----------------------------------------------------
CREATE VIEW vw_Noticias AS
SELECT 
    n.idNoticia,
    n.titulo AS TituloNoticia,
    n.contenido AS ContenidoNoticia,
    n.fechaPublicacion AS FechaPublicacion,
    u.Pnom + ' ' + u.Pappe AS PublicadoPor,
    a.nom_actividad AS ActividadRelacionada,
    ta.nom AS TipoActividad,
    p.nom_patro AS PatrocinadorActividad,
    DATEDIFF(day, n.fechaPublicacion, GETDATE()) AS DiasDesdePublicacion
FROM Noticia n
INNER JOIN Administrador adm ON n.Administrador_idAdministrador = adm.idAdministrador
INNER JOIN usuario u ON adm.Usuario_idUsuario = u.idUsuario
INNER JOIN Actividad a ON n.Actividad_idActividad = a.idActividad
INNER JOIN Tipo_Actividad ta ON a.Tipo_Actividad_idTipo_Actividad = ta.idTipo_Actividad
INNER JOIN Patrocinador p ON a.Patrocinador_idPatrocinador = p.idPatrocinador;
GO

-- -----------------------------------------------------
-- VISTA 5: vw_Reportes
-- Muestra información detallada de reportes
-- -----------------------------------------------------
CREATE VIEW vw_Reportes AS
SELECT 
    r.idReporte,
    r.mensaje AS MensajeReporte,
    r.fecha AS FechaReporte,
    r.motivo AS MotivoReporte,
    r.estado AS EstadoReporte,
    r.descripcion AS DescripcionDetallada,
    u.Pnom + ' ' + u.Pappe AS ReportadoPor,
    u.correo AS CorreoReportante,
    adm_u.Pnom + ' ' + adm_u.Pappe AS AdministradorAsignado,
    a.nom_actividad AS ActividadReportada,
    c.nom_creador AS CreadorActividad,
    CASE 
        WHEN r.estado = 'Resuelto' THEN 'Cerrado'
        WHEN r.estado = 'Pendiente' THEN 'En Espera'
        ELSE 'En Proceso'
    END AS EstadoSemaforo
FROM Reporte r
INNER JOIN usuario u ON r.Usuario_idUsuario = u.idUsuario
INNER JOIN Administrador adm ON r.Administrador_idAdministrador = adm.idAdministrador
INNER JOIN usuario adm_u ON adm.Usuario_idUsuario = adm_u.idUsuario
INNER JOIN Actividad a ON r.Actividad_idActividad = a.idActividad
INNER JOIN Creador c ON a.Patrocinador_idPatrocinador = c.idCreador;
GO

-- -----------------------------------------------------
-- VISTA 6: vw_Foro
-- Muestra información del foro con estadísticas
-- -----------------------------------------------------
CREATE VIEW vw_Foro AS
SELECT 
    f.idForo,
    f.nombreForo AS NombreForo,
    f.descripcion AS DescripcionForo,
    f.fecha_creacion AS FechaCreacion,
    a.nom_actividad AS ActividadRelacionada,
    ta.nom AS TipoActividad,
    c.nom_creador AS CreadorActividad,
    p.nom_patro AS Patrocinador,
    (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) AS TotalComentarios,
    (SELECT COUNT(*) FROM Noticia WHERE Actividad_idActividad = a.idActividad) AS TotalNoticiasRelacionadas,
    CASE 
        WHEN a.fecha_fin < GETDATE() THEN 'Foro Cerrado'
        ELSE 'Foro Activo'
    END AS EstadoForo
FROM Foro f
INNER JOIN Actividad a ON f.Actividad_idActividad = a.idActividad
INNER JOIN Tipo_Actividad ta ON a.Tipo_Actividad_idTipo_Actividad = ta.idTipo_Actividad
INNER JOIN Creador c ON a.Patrocinador_idPatrocinador = c.idCreador
INNER JOIN Patrocinador p ON a.Patrocinador_idPatrocinador = p.idPatrocinador;
GO

-- -----------------------------------------------------
-- VISTA 7: vw_Usuarios
-- Muestra información completa de usuarios
-- -----------------------------------------------------
CREATE VIEW vw_Usuarios AS
SELECT 
    u.idUsuario,
    u.Pnom + ' ' + ISNULL(u.Snom + ' ', '') + u.Pappe + ' ' + ISNULL(u.Sappe, '') AS NombreCompleto,
    u.correo AS CorreoElectronico,
    u.direccion AS Direccion,
    u.userName AS NombreUsuario,
    u.FechaRegistro AS FechaRegistro,
    t.num_telefono AS Telefono,
    CASE 
        WHEN c.idCreador IS NOT NULL THEN 'Creador'
        WHEN adm.idAdministrador IS NOT NULL THEN 'Administrador'
        WHEN d.idDonante IS NOT NULL THEN 'Donante'
        ELSE 'Usuario Regular'
    END AS RolUsuario,
    CASE 
        WHEN c.estado IS NOT NULL THEN c.estado
        WHEN c.estado IS NULL AND adm.idAdministrador IS NOT NULL THEN 'Activo'
        ELSE 'N/A'
    END AS EstadoUsuario,
    c.nom_creador AS NombreCreador,
    adm.niv_acceso AS NivelAcceso,
    adm.departamento AS Departamento,
    (SELECT COUNT(*) FROM Donacion WHERE Usuario_idUsuario = u.idUsuario) AS TotalDonacionesRealizadas,
    (SELECT ISNULL(SUM(monto), 0) FROM Donacion WHERE Usuario_idUsuario = u.idUsuario) AS MontoTotalDonado
FROM usuario u
LEFT JOIN Telefono t ON u.idUsuario = t.Usuario_idUsuario
LEFT JOIN Creador c ON u.idUsuario = c.Usuario_idUsuario
LEFT JOIN Administrador adm ON u.idUsuario = adm.Usuario_idUsuario
LEFT JOIN Donante d ON u.idUsuario = d.usuario_idUsuario;
GO

-- -----------------------------------------------------
-- VISTA 8: vw_PreguntasFrecuentes
-- Muestra preguntas frecuentes con categorización
-- -----------------------------------------------------
CREATE VIEW vw_PreguntasFrecuentes AS
SELECT 
    pf.idpreguntas_Frecuentes AS IdPregunta,
    pf.pregunta AS Pregunta,
    pf.respuesta AS Respuesta,
    pf.categoria AS Categoria,
    pf.fecha_creacion AS FechaCreacion,
    a.nom_actividad AS ActividadRelacionada,
    ta.nom AS TipoActividad,
    CASE 
        WHEN pf.Actividad_idActividad IS NULL THEN 'General'
        ELSE 'Específica'
    END AS TipoPregunta,
    DATEDIFF(day, pf.fecha_creacion, GETDATE()) AS DiasDesdeCreacion
FROM preguntas_Frecuentes pf
LEFT JOIN Actividad a ON pf.Actividad_idActividad = a.idActividad
LEFT JOIN Tipo_Actividad ta ON a.Tipo_Actividad_idTipo_Actividad = ta.idTipo_Actividad;
GO

-- -----------------------------------------------------
-- VISTA 9: vw_EstadisticasProyectos (Adicional 1)
-- Muestra estadísticas detalladas de proyectos
-- -----------------------------------------------------
CREATE VIEW vw_EstadisticasProyectos AS
SELECT 
    p.idProyecto,
    p.nombre_Proyecto AS NombreProyecto,
    p.descripcion AS DescripcionProyecto,
    p.fecha_Inicio AS FechaInicio,
    p.fecha_Fin AS FechaFin,
    p.estado AS EstadoProyecto,
    c.nom_creador AS CreadorProyecto,
    DATEDIFF(day, p.fecha_Inicio, p.fecha_Fin) AS DuracionDias,
    (SELECT COUNT(*) FROM Donacion WHERE Proyecto_idProyecto = p.idProyecto) AS TotalDonaciones,
    (SELECT ISNULL(SUM(monto), 0) FROM Donacion WHERE Proyecto_idProyecto = p.idProyecto) AS MontoRecaudado,
    (SELECT ISNULL(SUM(monto_Estimado), 0) FROM Presupuesto WHERE Proyecto_idProyecto = p.idProyecto) AS PresupuestoEstimado,
    (SELECT COUNT(*) FROM Recompensa WHERE Proyecto_idProyecto = p.idProyecto) AS TotalRecompensas,
    (SELECT COUNT(*) FROM Marketing WHERE Proyecto_idProyecto = p.idProyecto) AS TotalCampañasMarketing,
    CASE 
        WHEN p.fecha_Fin < GETDATE() THEN 'Finalizado'
        WHEN p.fecha_Inicio <= GETDATE() AND p.fecha_Fin >= GETDATE() THEN 'En Ejecución'
        ELSE 'Planificado'
    END AS EstadoEjecucion
FROM Proyecto p
INNER JOIN Creador c ON p.Creador_idCreador = c.idCreador;
GO

-- -----------------------------------------------------
-- VISTA 10: vw_Recompensas (Adicional 2)
-- Muestra información de recompensas disponibles
-- -----------------------------------------------------
CREATE VIEW vw_Recompensas AS
SELECT 
    r.idrecompensa AS IdRecompensa,
    r.nombre AS NombreRecompensa,
    r.descripcion AS DescripcionRecompensa,
    r.monto_minimo AS MontoMinimo,
    r.fecha_Entrega AS FechaEntregaEstimada,
    tr.nombre AS TipoRecompensa,
    tr.descripcion AS DescripcionTipo,
    p.nombre_Proyecto AS ProyectoAsociado,
    c.nom_creador AS CreadorProyecto,
    (SELECT COUNT(*) FROM Donacion WHERE monto >= r.monto_minimo AND Proyecto_idProyecto = r.Proyecto_idProyecto) AS DonantesElegibles,
    CASE 
        WHEN r.fecha_Entrega < GETDATE() THEN 'Entregada'
        WHEN r.fecha_Entrega >= GETDATE() THEN 'Pendiente'
        ELSE 'Por Definir'
    END AS EstadoEntrega
FROM Recompensa r
INNER JOIN TipoRecompensa tr ON r.TipoRecompensa_idTipoRecompensa = tr.idTipoRecompensa
INNER JOIN Proyecto p ON r.Proyecto_idProyecto = p.idProyecto
INNER JOIN Creador c ON p.Creador_idCreador = c.idCreador;
GO

-- -----------------------------------------------------
-- VISTA 11: vw_HistorialDonaciones (Adicional 3)
-- Muestra historial completo de donaciones con detalles de pago
-- -----------------------------------------------------
CREATE VIEW vw_HistorialDonaciones AS
SELECT 
    d.idDonacion,
    d.fecha AS FechaDonacion,
    d.monto AS Monto,
    d.anonima AS Anonima,
    d.mensaje AS Mensaje,
    u.Pnom + ' ' + u.Pappe AS Donante,
    u.correo AS CorreoDonante,
    p.nombre_Proyecto AS Proyecto,
    c.nom_creador AS Creador,
    pa.fecha AS FechaPago,
    pa.estado AS EstadoPago,
    pa.referencia AS Referencia,
    fp.nom AS FormaPago,
    m.monto AS MontoProcesado,
    CASE 
        WHEN r.idreembolso IS NOT NULL THEN 'Reembolsada'
        WHEN pa.estado = 'Completado' THEN 'Completada'
        WHEN pa.estado = 'Pendiente' THEN 'Pendiente'
        ELSE 'En Proceso'
    END AS EstadoFinal,
    r.motivo AS MotivoReembolso
FROM Donacion d
INNER JOIN usuario u ON d.Usuario_idUsuario = u.idUsuario
INNER JOIN Proyecto p ON d.Proyecto_idProyecto = p.idProyecto
INNER JOIN Creador c ON p.Creador_idCreador = c.idCreador
LEFT JOIN Pago pa ON pa.Donacion_idDonacion = d.idDonacion
LEFT JOIN Movimiento m ON m.Pago_idPago = pa.idPago
LEFT JOIN Forma_Pago fp ON m.Forma_Pago_idForma_Pago = fp.idForma_Pago
LEFT JOIN reembolso r ON r.Pago_idPago = pa.idPago;
GO

-- -----------------------------------------------------
-- VISTA 12: vw_ActividadesPopulares (Adicional 4)
-- Muestra las actividades más populares basadas en métricas
-- -----------------------------------------------------
CREATE VIEW vw_ActividadesPopulares AS
SELECT 
    a.idActividad,
    a.nom_actividad AS NombreActividad,
    a.fecha_inicio AS FechaInicio,
    a.fecha_fin AS FechaFin,
    ta.nom AS TipoActividad,
    p.nom_patro AS Patrocinador,
    (SELECT COUNT(*) FROM Beneficiario WHERE Actividad_idActividad = a.idActividad) AS TotalBeneficiarios,
    (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) AS TotalReseñas,
    (SELECT COUNT(*) FROM Noticia WHERE Actividad_idActividad = a.idActividad) AS TotalNoticias,
    (SELECT COUNT(*) FROM Reporte WHERE Actividad_idActividad = a.idActividad) AS TotalReportes,
    (SELECT ISNULL(AVG(LEN(r.descripcion)), 0) FROM Reseña r WHERE r.Actividad_idActividad = a.idActividad) AS PromedioLongitudReseñas,
    CASE 
        WHEN (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) >= 5 
             AND (SELECT COUNT(*) FROM Beneficiario WHERE Actividad_idActividad = a.idActividad) >= 3 THEN 'Muy Popular'
        WHEN (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) >= 3 THEN 'Popular'
        ELSE 'En Crecimiento'
    END AS NivelPopularidad,
    CASE 
        WHEN a.fecha_fin < GETDATE() THEN 'Finalizada'
        WHEN a.fecha_inicio <= GETDATE() AND a.fecha_fin >= GETDATE() THEN 'En Curso'
        ELSE 'Próxima'
    END AS Estado
FROM Actividad a
INNER JOIN Tipo_Actividad ta ON a.Tipo_Actividad_idTipo_Actividad = ta.idTipo_Actividad
INNER JOIN Patrocinador p ON a.Patrocinador_idPatrocinador = p.idPatrocinador
WHERE (SELECT COUNT(*) FROM Reseña WHERE Actividad_idActividad = a.idActividad) > 0
ORDER BY TotalReseñas DESC OFFSET 0 ROWS;
GO

PRINT 'Todas las vistas han sido creadas exitosamente.';
PRINT '';
PRINT '==============================================================';
PRINT 'LISTADO DE VISTAS CREADAS';
PRINT '==============================================================';
PRINT '';
PRINT 'VISTAS SOLICITADAS:';
PRINT '  1. vw_LandingPage - Estadísticas para página de inicio';
PRINT '  2. vw_Actividades - Información detallada de actividades';
PRINT '  3. vw_Donaciones - Detalle completo de donaciones';
PRINT '  4. vw_Noticias - Noticias con información relacionada';
PRINT '  5. vw_Reportes - Gestión de reportes del sistema';
PRINT '  6. vw_Foro - Información y estadísticas del foro';
PRINT '  7. vw_Usuarios - Información completa de usuarios';
PRINT '  8. vw_PreguntasFrecuentes - Preguntas frecuentes categorizadas';
PRINT '';
PRINT 'VISTAS ADICIONALES PARA CROWDFUNDING:';
PRINT '  9. vw_EstadisticasProyectos - Estadísticas de proyectos';
PRINT '  10. vw_Recompensas - Información de recompensas';
PRINT '  11. vw_HistorialDonaciones - Historial con detalles de pago';
PRINT '  12. vw_ActividadesPopulares - Actividades más populares';
PRINT '';
PRINT '==============================================================';
PRINT 'SCRIPT EJECUTADO EXITOSAMENTE';
PRINT '==============================================================';
GO
