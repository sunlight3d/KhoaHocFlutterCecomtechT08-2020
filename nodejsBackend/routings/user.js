const {
	jsonResponse,
	STATUS_SUCCESS,
	STATUS_FAILED
} = require('./jsonResponse')
const { Op } = require("sequelize")
const validator = require('../helpers/validator')
const {
	hashPassword,
	checkPassword,
	generateRandomString,	
} = require('../helpers/utilities')

module.exports = ({router, i18n, sequelize}) => {
		
	const validationRule = {
        "email": "required|email",        
        "password": "required|string|min:2",        
    }    	
	router.post('/register', async (request, response) => {		
		const {error, status} = await validator(request.body, validationRule)		
		if (!status) {
			jsonResponse({
				response,
				status: STATUS_FAILED,					
				message: `Validation error: ${error}`
			})
		} else {
			const {email, password} = request.body
			
			try {
				const User = await require('../models/user')(sequelize)									
				debugger	
				const newUser = await User.create({
					email: email, 
					password: await hashPassword(password),
					tokenKey: generateRandomString(40),				
				})
				debugger
				const {email, id, name, tokenKey} = newUser
				debugger
				jsonResponse({
					response,
					status: STATUS_SUCCESS,
					message: 'Register user successfully',
					data: {email, id, name, tokenKey}
				})
			}catch(exception) {
				debugger
				jsonResponse({
					response,
					status: STATUS_FAILED,	
					message: `Cannot register new user: ${error}`,
					data: {}
				})
			}
		}
	})		
	router.post('/login', async (request, response) => {
		validator(request.body, validationRule, {}, async (err, status) => {
			if (!status) {
				jsonResponse({
					response,
					status: STATUS_FAILED,	
					message: `Validation error: ${err}`
				})
			} else {
				const {email, password} = request.body
				try {
					const user = await User.findOne({
						email						
					})
					if(user == null) {
						jsonResponse({
							response,
							status: STATUS_FAILED,	
							message: 'Cannot find user',
							data: {}
						})	
					}
					if(await checkPassword({password, hashedPassword: user.password}) == false) {
						jsonResponse({
							response,
							status: STATUS_FAILED,	
							message: 'Wrong email and password',
							data: {email, id, name, tokenKey}
						})
					}					
					jsonResponse({
						response,
						status: STATUS_SUCCESS,	
						message: 'Register user successfully',
						data: {email, id, name, tokenKey}
					})
				}catch(exception) {
					jsonResponse({
						response,
						status: STATUS_FAILED,	
						message: `Cannot register new user: ${err}`,
						data: {}
					})
				}				
			}
		})		
	})		
	return router
}