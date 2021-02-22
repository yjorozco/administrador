const { Model } = require('sequelize');

class Usuarios extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            apellido: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            foto: {
                type: DataTypes.TEXT
            },
            direccion: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            telefono: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            correo: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            password: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            activo: {
                type: DataTypes.BOOLEAN,
                allowNull: false
            },
            codigo_activacion: {
                type: DataTypes.TEXT
            }
        }, {
            sequelize,
            modelName: 'Usuarios',
            tableName: 'usuarios',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsToMany(models.Roles, { through: models.UsuariosRoles, foreignKey: 'id_usuarios', as: 'Roles' })
    }

}






module.exports = Usuarios;


