module.exports = ({response, status, data, message, i18n}) => {
	return response.json({
		response, 
		status, 
		data, 
		message: i18n.__(message),
		timestamp: Date.now()
	})
}