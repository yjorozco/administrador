const { Model } = require('sequelize');
const Roles = require('./Roles');
const Usuarios = require('./Usuarios');
class UsuariosRoles extends Model {

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
            id_usuarios: {
                type: DataTypes.INTEGER,
                references: {
                    model: Usuarios,
                    key: 'id'
                }
            }
        }, {
            sequelize,
            modelName: 'UsuariosRoles',
            tableName: 'usuarios_roles',
            timestamps: false
        });

    }

    static associate(models) {

        this.belongsTo(models.Usuarios, { foreignKey: 'id_roles'  });
        this.belongsTo(models.Roles, { foreignKey: 'id_usuarios'  }); 
    }
}




module.exports = UsuariosRoles;