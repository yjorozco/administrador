const { Model } = require('sequelize');
class Intensidades extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false,
                unique: true
            },
            valor: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        }, {
            sequelize,
            modelName: 'Intensidades',
            tableName: 'intensidades',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsToMany(models.Preguntas, { through: models.PreguntasIntensidades, foreignKey: 'id_intensidades', as: 'Preguntas' })  
        this.hasMany(models.EncuestasDetalles, { as:'EncuestasDetalles' })  
        
    }
}


module.exports = Intensidades;