const { Model } = require('sequelize');
class Encuestas extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            id_usuarios: {
                type: DataTypes.INTEGER,
                allowNull: false
            },
            pais: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            estado: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            ciudad: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            codigo: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            intensidad: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            ip: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            longitud: {
                type: DataTypes.DECIMAL,
                allowNull: false
            },
            latitud: {
                type: DataTypes.DECIMAL,
                allowNull: false
            },
            fecha_creacion: {
                type: DataTypes.DATE,
                allowNull: false
            }

        }, {
            sequelize,
            modelName: 'Encuestas',
            tableName: 'encuestas',
            timestamps: false
        });

    }

    static associate(models) {
        this.hasMany(models.EncuestasDetalles, { foreignKey: 'id_encuestas', as:'EncuestasDetalles' })  
        this.belongsTo(models.Usuarios, { foreignKey: 'id_usuarios', targetKey: 'id', as: 'Usuarios' }) 
    }
}


module.exports = Encuestas;