const Sequelize = require('sequelize');
const sequelize  = require('../database/database');
const Roles = require('./Roles');
const Permisos = require('./Permisos');

const RolesPermisos = sequelize.define('roles_permisos', {
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
    id_permisos:  {
        type: Sequelize.INTEGER,
        references: {
          model: Permisos, 
          key: 'id'
        }
    }
}, {
    timestamps: false
});

Roles.belongsToMany(Permisos, { through: RolesPermisos, foreignKey: 'id_roles'  });
Permisos.belongsToMany(Roles, { through: RolesPermisos, foreignKey: 'id_permisos'  });
module.exports = RolesPermisos;