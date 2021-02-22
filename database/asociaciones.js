const { DataTypes } = require("sequelize");
const sequelize = require('./database');
// pass your sequelize config here

const Permisos = require("../models/Permisos");
const Roles = require("../models/Roles");
const RolesPermisos = require("../models/RolesPermisos");
const Usuarios = require("../models/Usuarios");
const UsuariosRoles = require("../models/UsuariosRoles");


const models = {
    Permisos: Permisos.init(sequelize, DataTypes),
    Roles: Roles.init(sequelize, DataTypes),
    RolesPermisos: RolesPermisos.init(sequelize, DataTypes),
    Usuarios: Usuarios.init(sequelize, DataTypes),
    UsuariosRoles: UsuariosRoles.init(sequelize, DataTypes),
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