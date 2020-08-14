const STATUS_SUCCESS = 'STATUS_SUCCESS'
const STATUS_FAILED = 'STATUS_FAILED'

const jsonResponse = ({response, status, data, message, i18n}) => 
	response.json({
		response, 
		status, 
		data, 
		message: i18n.__(message),
		timestamp: Date.now()
	})


module.exports = {
	jsonResponse,
	STATUS_SUCCESS,
	STATUS_FAILED
}