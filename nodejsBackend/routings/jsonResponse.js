const STATUS_SUCCESS = 'STATUS_SUCCESS'
const STATUS_FAILED = 'STATUS_FAILED'

const jsonResponse = ({response, status, data, message, i18n}) => {
	response.json({		
		status, 
		data, 
		message: i18n.__(message),
		timestamp: Date.now()
	})
}
const getMessageFromException = (exception) => {
	debugger
	if(exception.error) {
		if(Object.keys(exception.error.errors).length> 0) {			 
			 return Object.keys(exception.error.errors).map(
				 key => exception.error.errors[key]
			 ).join(',')			 
		}
	}else if(exception.errors){
		if(exception.errors.length > 0) {
			return exception.errors[0].message
		}
	}
	return ''
}
module.exports = {
	getMessageFromException,
	jsonResponse,
	STATUS_SUCCESS,
	STATUS_FAILED
}


