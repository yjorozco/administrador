const { Model } = require('sequelize');
class Permisos extends Model {
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
            modelName: 'Permisos',
            tableName: 'permisos',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsToMany(models.Roles, { through:models.RolesPermisos, foreignKey: 'id_permisos', as:'Roles' })  
    }
}


module.exports = Permisos;