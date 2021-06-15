const { DataTypes, Model } = require('sequelize');
const sequelize = require('../database/database');
const { Preguntas } = require('../database/asociaciones');
const { Intensidades } = require('../database/asociaciones');
class PreguntasIntensidades extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            id_preguntas: {
                type: DataTypes.INTEGER,
                references: {
                    model: Preguntas,
                    key: 'id'
                }
            },
            id_intensidades: {
                type: DataTypes.INTEGER,
                references: {
                    model: Intensidades,
                    key: 'id'
                }
            }

        }, {
            sequelize,
            modelName: 'PreguntasIntensidades',
            tableName: 'preguntas_intensidades',
            timestamps: false
        });
    }

    static associate(models) {
        this.belongsTo(models.Preguntas, { foreignKey: 'id_preguntas', as: 'Preguntas' });
        this.belongsTo(models.Intensidades, { foreignKey: 'id_intensidades', as: 'Intensidades' })
        this.hasMany(models.EncuestasDetalles, { foreignKey: 'id_preguntas_intensidades', as: 'EncuestasDetalles' })
    }
}

module.exports = PreguntasIntensidades;