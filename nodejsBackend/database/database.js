const mysql = require('mysql')
const mysql2 = require('mysql2')
const { Sequelize } = require('sequelize')
const { HOSTNAME, DB_PORT, DB_NAME } = require("../constants/constants")

module.exports = async () => {
	try {
		const sequelize = new Sequelize(
			DB_NAME,
			DB_USERNAME,
			DB_PASSWORD,
			{
				dialect: 'mysql',
				dialectModule: mysql2, 
				host: HOSTNAME,
				port: DB_PORT
			})
		sequelize.authenticate()
		console.log('Connection Sequelize successfully.')
		return sequelize
	} catch(exception){
		console.error('Sequelize connect database failed:', exception)
		return null
	}
}
