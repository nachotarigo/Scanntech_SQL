CREATE DATABASE IF NOT EXISTS Tarigo_Entrega1;
USE Tarigo_Entrega1;
-- 1. Barrios
CREATE TABLE IF NOT EXISTS barrios (
    id_barrio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- 2. Tipos de Césped
CREATE TABLE IF NOT EXISTS tipos_cesped (
    id_cesped INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL
);

-- 3. Tipos de Cancha
CREATE TABLE IF NOT EXISTS tipos_cancha (
    id_tipo_cancha INT AUTO_INCREMENT PRIMARY KEY,
    jugadores_por_lado INT NOT NULL,
    descripcion VARCHAR(100)
);

-- 4. Servicios
CREATE TABLE IF NOT EXISTS servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion VARCHAR(255)
);

-- 5. Empresas Administradoras
CREATE TABLE IF NOT EXISTS empresas_admin (
    id_empresa INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    telefono VARCHAR(20),
    email VARCHAR(150)
);

-- 6. Canchas
CREATE TABLE IF NOT EXISTS canchas (
    id_cancha INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(150),
    id_barrio INT,
    id_cesped INT,
    id_tipo_cancha INT,
    empresa_admin_id INT,
    precio_hora DECIMAL(10,2),
    iluminacion TINYINT,
    FOREIGN KEY (id_barrio) REFERENCES barrios(id_barrio),
    FOREIGN KEY (id_cesped) REFERENCES tipos_cesped(id_cesped),
    FOREIGN KEY (id_tipo_cancha) REFERENCES tipos_cancha(id_tipo_cancha),
    FOREIGN KEY (empresa_admin_id) REFERENCES empresas_admin(id_empresa)
);

-- 7. Cancha_Servicio
CREATE TABLE IF NOT EXISTS cancha_servicio (
    id_cancha INT,
    id_servicio INT,
    PRIMARY KEY (id_cancha, id_servicio),
    FOREIGN KEY (id_cancha) REFERENCES canchas(id_cancha),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

-- 8. Clientes
CREATE TABLE IF NOT EXISTS clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono VARCHAR(20),
    email VARCHAR(150)
);

-- 9. Estados de Reserva
CREATE TABLE IF NOT EXISTS estados_reserva (
    id_estado_reserva INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50)
);

-- 10. Reservas
CREATE TABLE IF NOT EXISTS reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cancha INT,
    id_cliente INT,
    estado_reserva_id INT,
    fecha DATE,
    hora_inicio TIME,
    hora_fin TIME,
    monto_total DECIMAL(10,2),
    FOREIGN KEY (id_cancha) REFERENCES canchas(id_cancha),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (estado_reserva_id) REFERENCES estados_reserva(id_estado_reserva)
);

-- 11. Métodos de Pago
CREATE TABLE IF NOT EXISTS metodos_pago (
    id_metodo_pago INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(100)
);

-- 12. Pagos
CREATE TABLE IF NOT EXISTS pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT,
    metodo_pago_id INT,
    monto DECIMAL(10,2),
    fecha_pago DATETIME,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (metodo_pago_id) REFERENCES metodos_pago(id_metodo_pago)
);

-- 13. Disponibilidad de Cancha
CREATE TABLE IF NOT EXISTS disponibilidad_cancha (
    id_disponibilidad INT AUTO_INCREMENT PRIMARY KEY,
    id_cancha INT,
    dia_semana TINYINT,
    hora_inicio TIME,
    hora_fin TIME,
    FOREIGN KEY (id_cancha) REFERENCES canchas(id_cancha)
);

-- 14. Opiniones
CREATE TABLE IF NOT EXISTS opiniones (
    id_opinion INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    id_cancha INT,
    puntuacion INT,
    comentario VARCHAR(255),
    fecha DATE,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_cancha) REFERENCES canchas(id_cancha)
);