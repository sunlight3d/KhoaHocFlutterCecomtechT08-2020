const {
	jsonResponse,
	getMessageFromException,
	STATUS_SUCCESS,
	STATUS_FAILED
} = require('./jsonResponse')
const { Op } = require("sequelize")
const validator = require('../helpers/validator')
const GET_ALL_PRODUCTS = '/fetch_products'

module.exports = ({router, i18n, sequelize, app}) => {		
    /*ko can tokenKy van lay duoc data
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
    */
	router.get(GET_ALL_PRODUCTS, async (request, response) => {		
        
        const {offset = 0, limit = 10} = request.query 
		try {						
			if (offset < 0 || isNaN(offset) ) {
				jsonResponse({
					response,
					status: STATUS_FAILED,
					message: `Validation error: ${error}`
				})
				return
            }			            
            const Product = await require('../models/product')(sequelize)			            
            let products = await Product.findAll({
                where: {},                
                offset: parseInt(offset),
                limit: parseInt(limit)
            })
            debugger
			jsonResponse({
				response,
				status: STATUS_SUCCESS,
                message: `Query successful, length = ${products.length}`,                
                data: products,	                
				i18n
			})
			return
		} catch (exception) {
			debugger
			jsonResponse({
				response,
				status: STATUS_FAILED,
				message: `Cannot query: ${getMessageFromException(exception)}`,
				data: [],
				i18n
			})
		}		
	})			
	return router
}