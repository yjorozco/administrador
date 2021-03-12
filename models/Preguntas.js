const { Model } = require('sequelize');
class Preguntas extends Model {
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
            orden:{
                type: DataTypes.INTEGER,
                allowNull: false,
            }

        }, {
            sequelize,
            modelName: 'Preguntas',
            tableName: 'preguntas',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsToMany(models.Intensidades, { through: models.PreguntasIntensidades, foreignKey: 'id_preguntas', as: 'Intensidades' })
        this.hasMany(models.EncuestasDetalles, { foreignKey: 'id_preguntas', as:'EncuestasDetalles' })  

    }
}


module.exports = Preguntas;