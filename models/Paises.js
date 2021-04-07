const { Model } = require('sequelize');
class Paises extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false                
            },
            codigo: {
                type: DataTypes.TEXT,
                allowNull: false,
                primaryKey: true
            },
            capital: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            provincia: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            area: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            poblacion: {
                type: DataTypes.TEXT,
                allowNull: false
            }

        }, {
            sequelize,
            modelName: 'Paises',
            tableName: 'pais',
            timestamps: false
        });

    }

    static associate(models) {        
       // this.hasMany(models.Estados, { foreignKey: 'codigo', sourceKey: 'codigo', as:'Estados' })  
    }
}



module.exports = Paises;