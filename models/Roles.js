const { Model } = require('sequelize');

class Roles extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false
            }
        }, {
            sequelize,
            modelName: "Roles",
            tableName: "roles",
            timestamps: false
        });
    }
    static associate(models) {
        this.belongsToMany(models.Usuarios, { through: models.UsuariosRoles, foreignKey: 'id_roles', as: 'Usuarios' })
        this.belongsToMany(models.Permisos, { through: models.RolesPermisos, foreignKey: 'id_roles', as: 'Permisos' })
    }
}




module.exports = Roles;





