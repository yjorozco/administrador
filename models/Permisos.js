const Sequelize = require('sequelize');
const { sequelize } = require('../database/database');

const Permisos = sequelize.new('permisos', {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true
    },
    nombre: {
        type: Sequelize.TEXT,
        allowNull: false
    }
}, {
    timestamps: false
});

module.exports = Permisos;