const { DataTypes, Model } = require('sequelize');
const sequelize = require('../database/database');
const Roles = require('./Roles');
const Permisos = require('./Permisos');
class RolesPermisos extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            id_roles: {
                type: DataTypes.INTEGER,
                references: {
                    model: Roles,
                    key: 'id'
                }
            },
            id_permisos: {
                type: DataTypes.INTEGER,
                references: {
                    model: Permisos,
                    key: 'id'
                }
            }
        }, {
            sequelize,
            modelName: 'RolesPermisos',
            tableName: 'roles_permisos',
            timestamps: false
        });
    }

    static associate(models) {
        this.belongsTo(models.Roles, { foreignKey: 'id_roles' });
        this.belongsTo(models.Permisos, { foreignKey: 'id_permisos' })
    }
}

module.exports = RolesPermisos;