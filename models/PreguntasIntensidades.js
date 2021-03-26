const { DataTypes, Model } = require('sequelize');
const sequelize = require('../database/database');
const Preguntas = require('./Preguntas');
const Intensidades = require('./Intensidades');
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
            },
            nombre: {
                type: DataTypes.TEXT,
                allowNull: false
            },

        }, {
            sequelize,
            modelName: 'PreguntasIntensidades',
            tableName: 'preguntas_intensidades',
            timestamps: false
        });
    }

    static associate(models) {
        this.belongsTo(models.Preguntas, { foreignKey: 'id_preguntas' });
        this.belongsTo(models.Intensidades, { foreignKey: 'id_intensidades' })
    }
}

module.exports = PreguntasIntensidades;