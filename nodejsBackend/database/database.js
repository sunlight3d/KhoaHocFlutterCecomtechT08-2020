const mysql = require('mysql')
const mysql2 = require('mysql2')
const { Sequelize } = require('sequelize')
const { HOSTNAME, POST, MYSQL } = require("../constants/constants")
const {DB_NAME,DB_PORT, USER_NAME, PASSWORD} = MYSQL

module.exports = () => {
	try {
		const sequelize = new Sequelize(
			DB_NAME,
			USER_NAME,
			PASSWORD,
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
