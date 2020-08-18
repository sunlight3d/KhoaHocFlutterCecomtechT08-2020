CREATE DATABASE NodejsBackend;
USE NodejsBackend;
CREATE TABLE IF NOT EXISTS User(
	id INT AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(400) NOT NULL,
	password VARCHAR(400) NOT NULL,
	fullName VARCHAR(400),
	createdDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	expiredDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	tokenKey VARCHAR(400),
	role INT DEFAULT 1,	
	isActive INT	
);
/*
module.exports = (sequelize) => {
	return sequelize.define('User', {
		id: {
			type: DataTypes.INTEGER(11),
			allowNull: false,
			primaryKey: true,
			autoIncrement: true
		},
		email: {
			type: DataTypes.STRING(400),
			allowNull: 
		},
		password: {
			type: DataTypes.STRING(400),
			allowNull: false
		},
		fullName: {
			type: DataTypes.STRING(400),
			allowNull: true
		},
		expiredDate: {
			type: DataTypes.DATE,
			allowNull: false
		},
		tokenKey: {
			type: DataTypes.STRING(200),
			allowNull: true
		},
		isActive: {
			type: DataTypes.INTEGER,			
			defaultValue: 0,
			allowNull: false
		},
		createdDate: {
			type: DataTypes.DATE,
			allowNull: true,
			defaultValue: sequelize.literal('CURRENT_TIMESTAMP')
		},
	}, {
		tableName: 'User',
		timestamps: false,
	})
}
*/