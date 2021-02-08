const Sequelize = require('sequelize');
const sequelize = require('../database/database');

const Usuarios = sequelize.define('usuarios', {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true
    },
    nombre: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    apellido: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    foto: {
        type: Sequelize.TEXT
    },
    direccion: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    telefono: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    correo: {
        type: Sequelize.TEXT,
        allowNull: false
    },
    password: {
        type: Sequelize.TEXT,
        allowNull: false
    }
}, {
    timestamps: false
});

module.exports = Usuarios;

