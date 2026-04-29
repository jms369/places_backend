
CREATE TABLE lugares (
                id_lugares VARCHAR NOT NULL,
                nombre VARCHAR(200) NOT NULL,
                descripcion VARCHAR(500) NOT NULL,
                provincia VARCHAR(100) NOT NULL,
                municipio VARCHAR(100) NOT NULL,
                departamento VARCHAR(100) NOT NULL,
                ubicacion VARCHAR(300) NOT NULL,
                latitud DECIMAL NOT NULL,
                longitud DECIMAL NOT NULL,
                url VARCHAR(150) NOT NULL,
                geolocalizacion DECIMAL(150) NOT NULL,
                PRIMARY KEY (id_lugares)
);


CREATE TABLE horarios (
                id_horarios INT AUTO_INCREMENT NOT NULL,
                dia VARCHAR(50) NOT NULL,
                inicio TIME NOT NULL,
                fin TIME NOT NULL,
                id_lugares VARCHAR NOT NULL,
                PRIMARY KEY (id_horarios)
);


CREATE TABLE funcionalidades (
                id_funcionalidades INT NOT NULL,
                nombre VARCHAR(50) NOT NULL,
                PRIMARY KEY (id_funcionalidades)
);


CREATE TABLE roles (
                id_rol INT NOT NULL,
                nombre VARCHAR(100) NOT NULL,
                PRIMARY KEY (id_rol)
);


CREATE TABLE privilegios (
                id_funcionalidades INT NOT NULL,
                id_rol INT NOT NULL,
                PRIMARY KEY (id_funcionalidades, id_rol)
);


CREATE TABLE personas (
                id_persona INT AUTO_INCREMENT NOT NULL,
                nombres VARCHAR(100) NOT NULL,
                primer_apellido VARCHAR(100) NOT NULL,
                segundo_apellido VARCHAR(100),
                ci INT NOT NULL,
                complemento VARCHAR(2),
                fecha_nacimiento DATE NOT NULL,
                genero VARCHAR(50) NOT NULL,
                direccion VARCHAR(200) NOT NULL,
                telefono_fijo INT,
                email VARCHAR(100) NOT NULL,
                celular INT,
                PRIMARY KEY (id_persona)
);


CREATE TABLE usuarios (
                id_personas INT NOT NULL,
                name_usuario VARCHAR(50) AUTO_INCREMENT NOT NULL,
                contrasena VARCHAR(300) NOT NULL,
                PRIMARY KEY (id_personas)
);


CREATE INDEX usuarios_idx
 ON usuarios
 ( name_usuario );

CREATE INDEX usuarios_idx1
 ON usuarios
 ( name_usuario ASC );

CREATE INDEX usuarios_idx2
 ON usuarios
 ( name_usuario );

CREATE TABLE comentarios (
                id_comentarios INT AUTO_INCREMENT NOT NULL,
                id_lugares VARCHAR NOT NULL,
                comentario VARCHAR(500) NOT NULL,
                calificacion INT NOT NULL,
                fecha DATE NOT NULL,
                id_personas INT NOT NULL,
                id_recomentarios INT NOT NULL,
                PRIMARY KEY (id_comentarios, id_lugares)
);


CREATE TABLE fotos (
                id_fotos VARCHAR AUTO_INCREMENT NOT NULL,
                descripcion VARCHAR(500) NOT NULL,
                url VARCHAR(150) NOT NULL,
                id_lugares VARCHAR NOT NULL,
                id_comentarios INT NOT NULL,
                PRIMARY KEY (id_fotos)
);


CREATE TABLE favoritos (
                id_personas INT NOT NULL,
                id_lugares VARCHAR NOT NULL,
                PRIMARY KEY (id_personas, id_lugares)
);


CREATE TABLE cuentas (
                id_rol INT NOT NULL,
                id_personas INT NOT NULL,
                PRIMARY KEY (id_rol, id_personas)
);


ALTER TABLE favoritos ADD CONSTRAINT lugares_favoritos_fk
FOREIGN KEY (id_lugares)
REFERENCES lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fotos ADD CONSTRAINT lugares_fotos_fk
FOREIGN KEY (id_lugares)
REFERENCES lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE horarios ADD CONSTRAINT lugares_horarios_fk
FOREIGN KEY (id_lugares)
REFERENCES lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE comentarios ADD CONSTRAINT lugares_comentarios_fk
FOREIGN KEY (id_lugares)
REFERENCES lugares (id_lugares)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE privilegios ADD CONSTRAINT funcionalidades_privilegios_fk
FOREIGN KEY (id_funcionalidades)
REFERENCES funcionalidades (id_funcionalidades)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuentas ADD CONSTRAINT roles_cuentas_fk
FOREIGN KEY (id_rol)
REFERENCES roles (id_rol)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE privilegios ADD CONSTRAINT roles_privilegios_fk
FOREIGN KEY (id_rol)
REFERENCES roles (id_rol)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE usuarios ADD CONSTRAINT personas_usuarios_fk
FOREIGN KEY (id_personas)
REFERENCES personas (id_persona)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuentas ADD CONSTRAINT usuarios_cuentas_fk
FOREIGN KEY (id_personas)
REFERENCES usuarios (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE favoritos ADD CONSTRAINT usuarios_favoritos_fk
FOREIGN KEY (id_personas)
REFERENCES usuarios (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE comentarios ADD CONSTRAINT usuarios_comentarios_fk
FOREIGN KEY (id_personas)
REFERENCES usuarios (id_personas)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE comentarios ADD CONSTRAINT comentarios_comentarios_fk
FOREIGN KEY (id_recomentarios)
REFERENCES comentarios (id_comentarios)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fotos ADD CONSTRAINT comentarios_fotos_fk
FOREIGN KEY (id_comentarios)
REFERENCES comentarios (id_comentarios)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
