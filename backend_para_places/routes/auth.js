const express = require('express');
const router = express.Router();
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const mysql = require('mysql2');

// Conexión a la base de datos
const db = mysql.createConnection({
  host: 'localhost',
  port: 3307,
  user: 'root',
  password: 'root',
  database: 'places_db'
});

//  LOGIN
router.post('/login', (req, res) => {
  const { name_usuario, contrasena } = req.body;

  db.query('SELECT * FROM usuarios WHERE name_usuario = ?', [name_usuario], (err, results) => {
    if (err) return res.status(500).json({ message: 'Error en el servidor' });
    if (results.length === 0) return res.status(401).json({ message: 'Usuario no encontrado' });

    const usuario = results[0];
    const contrasenaValida = bcrypt.compareSync(contrasena, usuario.contrasena);

    if (!contrasenaValida) return res.status(401).json({ message: 'Contraseña incorrecta' });

    const token = jwt.sign({ id: usuario.id_personas }, 'mi_secreto_jwt', { expiresIn: '1h' });
    res.json({ message: 'Login exitoso', token });
  });
});

//  REGISTRO AUTOMÁTICO (registro)
router.post('/register', (req, res) => {
  const {
    nombres,
    primer_apellido,
    ci,
    fecha_nacimiento,
    genero,
    direccion,
    email,
    name_usuario,
    contrasena
  } = req.body;

  const hash = bcrypt.hashSync(contrasena, 10);

  // Crear registro en la tabla personas
  db.query(
    'INSERT INTO personas (nombres, primer_apellido, ci, fecha_nacimiento, genero, direccion, email) VALUES (?, ?, ?, ?, ?, ?, ?)',
    [nombres, primer_apellido, ci, fecha_nacimiento, genero, direccion, email],
    (err, result) => {
      if (err) {
        console.log(err);
        return res.status(500).json({ message: 'Error al registrar persona' });
      }

      const id_personas = result.insertId; // obtiene el ID generado automáticamente

      //  Crear registro en la tabla usuarios vinculado a la persona
      db.query(
        'INSERT INTO usuarios (id_personas, name_usuario, contrasena) VALUES (?, ?, ?)',
        [id_personas, name_usuario, hash],
        (err2) => {
          if (err2) {
            console.log(err2);
            return res.status(500).json({ message: 'Error al registrar usuario' });
          }
          res.json({ message: 'Usuario registrado correctamente' });
        }
      );
    }
  );
});



//  LOGOUT (simbólico)
router.delete('/logout', (req, res) => {
  res.json({ message: 'Sesión cerrada correctamente' });
});

//  TOKEN REFRESH
router.get('/token', (req, res) => {
  const token = req.headers['authorization'];
  if (!token) return res.status(403).json({ message: 'Token requerido' });

  jwt.verify(token, 'mi_secreto_jwt', (err, decoded) => {
    if (err) return res.status(401).json({ message: 'Token inválido o expirado' });
    const nuevoToken = jwt.sign({ id: decoded.id }, 'mi_secreto_jwt', { expiresIn: '1h' });
    res.json({ message: 'Token renovado correctamente', token: nuevoToken });
  });
});

module.exports = router;
