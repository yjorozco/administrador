const { Model } = require('sequelize');
class EncuestasDetalles extends Model {
    static init(sequelize, DataTypes) {
        return super.init({
            id: {
                type: DataTypes.INTEGER,
                primaryKey: true
            },
            id_encuestas: {
                type: DataTypes.DATE,
                allowNull: false,
                unique: true
            },
            id_intensidades: {
                type: DataTypes.INTEGER,
                allowNull: false
            },
            id_preguntas: {
                type: DataTypes.INTEGER,
                allowNull: false
            }
        }, {
            sequelize,
            modelName: 'EncuestasDetalles',
            tableName: 'encuestas_detalles',
            timestamps: false
        });

    }

    static associate(models) {
        this.belongsTo(models.Encuestas, { foreignKey:'id_encuestas', targetKey:'id', as:'Encuestas' });
        this.belongsTo(models.Intensidades, { foreignKey:'id_intensidades',  targetKey:'id', as:'Intensidades' });
        this.belongsTo(models.Preguntas, { foreignKey:'id_preguntas', targetKey:'id', as:'Preguntas' });
    }
}


module.exports = EncuestasDetalles;