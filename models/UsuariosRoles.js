const Sequelize = require('sequelize');
const  sequelize = require('../database/database');
const Roles = require('./Roles');
const Usuarios = require('./Usuarios');

const UsuariosRoles = sequelize.define('usuarios_roles', {
    id: {
        type: Sequelize.INTEGER,
        primaryKey: true
    },
    id_roles: {
        type: Sequelize.INTEGER,
        references: {
          model: Roles , 
          key: 'id'
        }
    },
    id_usuarios:  {
        type: Sequelize.INTEGER,
        references: {
          model: Usuarios, 
          key: 'id'
        }
    }
}, {
    timestamps: false
});

Usuarios.belongsToMany(Roles, {  through: UsuariosRoles,foreignKey: 'id_usuarios' });
Roles.belongsToMany(Usuarios, { through: UsuariosRoles, foreignKey: 'id_roles' });

module.exports = UsuariosRoles;