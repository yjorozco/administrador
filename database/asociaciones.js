const { DataTypes } = require("sequelize");
const sequelize = require('./database');
// pass your sequelize config here

const Permisos = require("../models/Permisos");
const Roles = require("../models/Roles");
const RolesPermisos = require("../models/RolesPermisos");
const Usuarios = require("../models/Usuarios");
const UsuariosRoles = require("../models/UsuariosRoles");
const Paises = require("../models/Paises");
const Estados = require("../models/Estados");
const Ciudades = require("../models/Ciudades");
const Encuestas = require("../models/Encuestas");
const EncuestasDetalles = require("../models/EncuestasDetalles");
const Intensidades = require('../models/Intensidades');
const Preguntas = require('../models/Preguntas');
const PreguntasIntensidades = require('../models/PreguntasIntensidades');
const models = {
    Permisos: Permisos.init(sequelize, DataTypes),
    Roles: Roles.init(sequelize, DataTypes),
    RolesPermisos: RolesPermisos.init(sequelize, DataTypes),
    Usuarios: Usuarios.init(sequelize, DataTypes),
    UsuariosRoles: UsuariosRoles.init(sequelize, DataTypes),
    Paises: Paises.init(sequelize, DataTypes),
    Estados: Estados.init(sequelize, DataTypes),
    Ciudades: Ciudades.init(sequelize, DataTypes),
    Encuestas: Encuestas.init(sequelize, DataTypes),
    EncuestasDetalles: EncuestasDetalles.init(sequelize, DataTypes),
    Intensidades: Intensidades.init(sequelize, DataTypes),
    Preguntas: Preguntas.init(sequelize, DataTypes),
    PreguntasIntensidades: PreguntasIntensidades.init(sequelize, DataTypes)
};

// Run `.associate` if it exists,
// ie create relationships in the ORM
Object.values(models)
    .filter(model => typeof model.associate === "function")
    .forEach(model => model.associate(models));

const db = {
    ...models,
    sequelize
};

module.exports = db;