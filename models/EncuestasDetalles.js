const { Model } = require('sequelize');
const { PreguntasIntensidades } = require('../database/asociaciones');
const { Encuestas } = require('../database/asociaciones');
class EncuestasDetalles extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            id_encuestas: {
                type: DataTypes.INTEGER,
                references: {
                    model: Encuestas,
                    key: 'id'
                }
            },
            id_preguntas_intensidades: {
                type: DataTypes.INTEGER,
                references: {
                    model: PreguntasIntensidades,
                    key: 'id'
                }
            }
        }, {
            sequelize,
            modelName: 'EncuestasDetalles',
            tableName: 'encuestas_detalles',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsTo(models.Encuestas, { foreignKey: 'id_encuestas', targetKey: 'id', as: 'Encuestas' });
        //  this.belongsTo(models.Intensidades, { foreignKey:'id_intensidades',  targetKey:'id', as:'Intensidades' });
        //  this.belongsTo(models.Preguntas, { foreignKey:'id_preguntas', targetKey:'id', as:'Preguntas' });
        this.belongsTo(models.PreguntasIntensidades, { foreignKey: 'id_preguntas_intensidades', targetKey: 'id', as: 'PreguntasIntensidades' });
    }
}


module.exports = EncuestasDetalles;