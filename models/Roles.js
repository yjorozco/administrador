const Sequelize = require('sequelize');
const  sequelize = require('../database/database');

const Roles = sequelize.define('roles', {
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

module.exports = Roles;