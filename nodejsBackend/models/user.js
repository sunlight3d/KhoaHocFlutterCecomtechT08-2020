const { DataTypes, Sequelize } = require('sequelize');
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
			allowNull: false
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
			defaultValue: Sequelize.literal('CURRENT_TIMESTAMP')
		},
	}, {
		tableName: 'User',
		timestamps: false,
	})
}
