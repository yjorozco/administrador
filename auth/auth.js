const express = require('express');
const router = express.Router();

const jwt = require('jsonwebtoken');
const passport = require('passport');


/* POST login. */
router.post('/login', function (req, res, next) {

    passport.authenticate('local', { session: false }, (err, user, info) => {

        if (err || !user) {
            return res.status(400).json({
                message: info ? info.message : 'Autenticación Fallida',
                user: user
            });
        }


        req.login(user, { session: false }, (err) => {
            if (err) {
                res.send(err);
            }


            const token = jwt.sign({ user }, '76175d01f9577203f737e74485ece6f843fcbf75');

            return res.json({ token });
        });
    })
        (req, res);

});

module.exports = router;