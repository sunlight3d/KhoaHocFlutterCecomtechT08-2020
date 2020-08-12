const jsonResponse = require('./jsonResponse')
const { Op } = require("sequelize")

module.exports = ({router, i18n, sequelize}) => {
	const User = require('../models/user')(sequelize)
	router.post('/register', async(req, res) => {

	})		
}