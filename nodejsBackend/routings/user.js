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
const {checkTokenKey} = require('./validator')
const REGISTER_USER = '/register'
const LOGIN_USER = '/login'
const LOGOUT_USER = '/logout'
const CHECK_TOKEN = '/check_token'
module.exports = ({router, i18n, sequelize, app}) => {		
	app.use(async (request, response, next) => {
		const { originalUrl } = request
		const routerPath = `/${originalUrl.split('/')[originalUrl.split('/').length-1]}`		
		if(routerPath == REGISTER_USER 
			|| routerPath == LOGIN_USER
			|| routerPath == CHECK_TOKEN
			|| routerPath == LOGOUT_USER) {			
			next()
			return
		}
		debugger
		const {email, tokenKey} = request.body
		if(await checkTokenKey({email, tokenKey})) {
			next()
		}
		
	})
	const rules = {
        "email": "required|email",        
        "password": "required|string|min:2",        
	}    		
	router.post(REGISTER_USER, async (request, response) => {		
		try {
			debugger
			const { error, status } = await validator(request.body, rules)
			if (!status) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: `Validation error: ${error}`
				})
				return
			}
			const { email, password } = request.body
			const User = await require('../models/user')(sequelize)
			const dayAfter30Days = new Date();
			dayAfter30Days.setDate(dayAfter30Days.getDate() + 30);			
			let newUser = await User.create({
				email,
				password: await hashPassword(password),
				tokenKey: generateRandomString(40),
				expiredDate: dayAfter30Days,
				isActive: 1,			
			})
			const { id, tokenKey } = newUser			
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
				message: 'Register user successfully',
				data: { email, id, tokenKey },				
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
	router.post(LOGIN_USER, async (request, response) => {
		debugger
		try {						
			const { email, password } = request.body
			const User = await require('../models/user')(sequelize)
			const foundUser = await User.findOne({where: {email} })
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
			const isMatch = await checkPassword({ password, hashedPassword: foundUser.password })		
			if(isMatch == false) {
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
	router.post(LOGOUT_USER, async (request, response) => {
		debugger
		try {						
			const { tokenKey, email } = request.body
			const User = await require('../models/user')(sequelize)
			const foundUser = await User.findOne({where: {tokenKey, email}})
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
			foundUser.tokenKey = ''
			foundUser.isActive = 0
			foundUser.expiredDate = new Date();				
			await foundUser.save()			
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
				message: 'logout user successfully',
				data: { },
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
	router.post(CHECK_TOKEN, async (request, response) => {		
		try {						
			const { tokenKey, email } = request.body
			const User = await require('../models/user')(sequelize)
			const foundUser = await User.findOne({where: {tokenKey, email}})
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
			let today = new Date()
			debugger
			foundUser.password = 'not show'
			if(foundUser.expiredDate >= today && foundUser.isActive == true) {
				jsonResponse({
					response,
					status: STATUS_SUCCESS,
					message: 'Token is ok',
					data: foundUser,
					i18n
				})						
			} else {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: 'Token is failed',
					data: { },
					i18n
				})						
			}						
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