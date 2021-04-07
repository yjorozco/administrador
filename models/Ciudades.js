const { Model } = require('sequelize');

class Ciudades extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false,
                primaryKey: true                
            },
            pais: {
                type: DataTypes.TEXT,
                allowNull: false,
                primaryKey: true
            },
            provincia: {
                type: DataTypes.TEXT,
                allowNull: false,
                primaryKey: true
            },
            poblacion: {
                type: DataTypes.INTEGER,
                allowNull: false
            },
            longitud: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            latitud: {
                type: DataTypes.TEXT,
                allowNull: false
            }

        }, {
            sequelize,
            modelName: 'Ciudad',
            tableName: 'ciudad',
            timestamps: false
        });

    }

    static associate(models) {        
      //  this.hasMany(models.Cidades, {  foreignKey: 'nombre', targetKey: 'nombre', as:'Ciudades' });
       // this.belongsTo(models.Estados, { foreignKey: 'codigo', sourceKey: 'codigo', as:'Estados' })    

    }
}


module.exports = Ciudades;