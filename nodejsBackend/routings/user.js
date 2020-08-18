const {
	jsonResponse,
	getMessageFromException,
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
	const rules = {
        "email": "required|email",        
        "password": "required|string|min:2",        
    }    	
	router.post('/register', async (request, response) => {		
		try {
			const { error, status } = await validator(request.body, rules)
			if (!status) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: `Validation error: ${error}`
				})
			}
			const { email, password } = request.body
			const User = await require('../models/user')(sequelize)
			const dayAfter30Days = new Date();
			dayAfter30Days.setDate(dayAfter30Days.getDate() + 30);			
			let newUser = await User.create({
				email,
				password: await hashPassword(password),
				tokenKey: generateRandomString(40),
			})
			const { id, tokenKey } = newUser			
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
				message: 'Register user successfully',
				data: { email, id, tokenKey },
				expiredDate: dayAfter30Days,
				isActive: 1,			
				i18n
			})
		} catch (exception) {
			debugger
			jsonResponse({
				response,
				status: STATUS_FAILED,
				message: `Cannot register new user: ${getMessageFromException(exception)}`,
				data: {},
				i18n
			})
		}		
	})		
	router.post('/login', async (request, response) => {
		try {						
			const { email, password } = request.body
			const User = await require('../models/user')(sequelize)
			const foundUser = await User.findOne({email})
			if(foundUser == null) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: 'Cannot find user',
					data: {},
					i18n
				})
				return
			}			
			if(await checkPassword({ password, hashedPassword: foundUser.password }) == false) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: 'Wrong email and password',
					data: {},
					i18n
				})
				return
			}			
			const dayAfter30Days = new Date();
			dayAfter30Days.setDate(dayAfter30Days.getDate() + 30);
			foundUser.expiredDate = dayAfter30Days
			foundUser.isActive = 1			
			await foundUser.save()
			const { id, tokenKey } = foundUser
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
				message: 'Login user successfully',
				data: { email, id, tokenKey },
				i18n
			})						
		} catch (exception) {			
			jsonResponse({
				response,
				status: STATUS_FAILED,
				message: `Cannot login user: ${getMessageFromException(exception)}`,
				data: {},
				i18n
			})
		}			
	})		
	/*
	router.post('/update', async (request, response) => {
		try {						
			const { email, image } = request.body
			
			const User = await require('../models/user')(sequelize)
			const foundUser = await User.findOne({email})
			if(foundUser == null) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: 'Cannot find user',
					data: {},
					i18n
				})
				return
			}			
			if(await checkPassword({ password, hashedPassword: foundUser.password }) == false) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: 'Wrong email and password',
					data: {},
					i18n
				})
				return
			}			
			const dayAfter30Days = new Date();
			dayAfter30Days.setDate(dayAfter30Days.getDate() + 30);
			foundUser.expiredDate = dayAfter30Days
			foundUser.isActive = 1			
			await foundUser.save()
			const { id, tokenKey } = foundUser
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
				message: 'Login user successfully',
				data: { email, id, tokenKey },
				i18n
			})						
		} catch (exception) {			
			jsonResponse({
				response,
				status: STATUS_FAILED,
				message: `Cannot login user: ${getMessageFromException(exception)}`,
				data: {},
				i18n
			})
		}		
			
	})	
	*/	
	return router
}