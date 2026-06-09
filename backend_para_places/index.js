const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

// Conexión a tu contenedor MySQL
const db = mysql.createConnection({
  host: 'localhost',
  port: 3307,
  user: 'root',
  password: 'root',
  database: 'places_db'
});

db.connect(err => {
  if (err) {
    console.error('❌ Error al conectar con MySQL:', err);
    return;
  }
  console.log('✅ Conectado a MySQL (Docker)');
});

// Endpoint de prueba
app.get('/lugares', (req, res) => {
  db.query('SELECT * FROM lugares', (err, results) => {
    if (err) {
      console.error(err);
      res.status(500).send('Error al obtener lugares');
      return;
    }
    res.json(results);
  });
});

app.listen(3000, () => console.log('🚀 Servidor Express corriendo en puerto 3000'));

// esto es para conectar a los endpoints login,register,logout,token
const authRoutes = require('./routes/auth');
app.use('/api', authRoutes);
