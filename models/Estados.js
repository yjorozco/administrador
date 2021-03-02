const { Model } = require('sequelize');
class Estados extends Model {
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
            poblacion: {
                type: DataTypes.INTEGER,
                allowNull: false
            },
            area: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            capital: {
                type: DataTypes.TEXT,
                allowNull: false
            },
            cap_prov: {
                type: DataTypes.TEXT,
                allowNull: false
            },

        }, {
            sequelize,
            modelName: 'Estados',
            tableName: 'provincia',
            timestamps: false
        });

    }

    static associate(models) {        
      //  this.hasMany(models.Cidades, {  foreignKey: 'nombre', targetKey: 'nombre', as:'Ciudades' });
     //   this.belongsTo(models.Paises, { foreignKey: 'codigo', sourceKey: 'codigo', as:'Paises' })    

    }
}


module.exports = Estados;