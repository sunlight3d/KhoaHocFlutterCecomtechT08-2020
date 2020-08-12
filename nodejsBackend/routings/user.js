const jsonResponse = require('./jsonResponse')
const { Op } = require("sequelize")
const validator = require('../helpers/validator')
const {
	hashPassword,
	checkPassword,
	generateRandomString
} = require('../helpers/utilities')

module.exports = ({router, i18n, sequelize}) => {
	const User = require('../models/user')(sequelize)
	const validationRule = {
        "email": "required|email",        
        "password": "required|string|min:2",
        "gender": "string"
    }    	
	router.post('/register', async (request, response) => {
		validator(request.body, validationRule, {}, (err, status) => {
			if (!status) {
				jsonResponse({
					response,
					status: 'failed',					
					message: `Validation error: ${err}`
				})
			} else {
				next()
			}
		})
		try {
			const newUser = await User.create({
				name, email, 
				password: hashPassword(password),
				tokenKey: generateRandomString(40),				
			})
			const {email, id, name, tokenKey} = newUser
			jsonResponse({
				response,
				status: 'ok',
				message: 'Register user successfully',
				data: {email, id, name, tokenKey}
			})
		}catch(exception) {

		}

	})		
}