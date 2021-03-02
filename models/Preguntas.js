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
            id_intensidades:{
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
        this.belongsTo(models.Intensidades, {
            foreignKey: "id_intensidades",
            as: "Intensidades",
        });
        this.hasMany(models.EncuestasDetalles, { as:'EncuestasDetalles' })  

    }
}


module.exports = Intensidades;