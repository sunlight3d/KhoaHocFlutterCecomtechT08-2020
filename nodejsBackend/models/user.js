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
			allowNull: true
		},
		fullName: {
			type: DataTypes.STRING(400),
			allowNull: true
		},
		expiredDate: {
			type: DataTypes.DATE,
			allowNull: true
		},
		tokenKey: {
			type: DataTypes.STRING(200),
			allowNull: true
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