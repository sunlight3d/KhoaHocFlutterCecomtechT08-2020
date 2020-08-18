const { DataTypes, Sequelize } = require('sequelize');
//sequelize-auto -o "./models1" -h localhost -u root -p 3306 -x "" -e mysql -d NodejsBackend
module.exports = async (sequelize) => {	
	return sequelize.define('User', {
		id: {
		  autoIncrement: true,
		  type: DataTypes.INTEGER(11),
		  allowNull: false,
		  primaryKey: true
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
		createdDate: {
		  type: DataTypes.DATE,
		  allowNull: false,
		  defaultValue: sequelize.fn('current_timestamp')
		},
		expiredDate: {
		  type: DataTypes.DATE,
		  allowNull: false,
		  defaultValue: sequelize.fn('current_timestamp')
		},
		tokenKey: {
		  type: DataTypes.STRING(400),
		  allowNull: true
		},
		role: {
		  type: DataTypes.INTEGER(11),
		  allowNull: true,
		  defaultValue: 1
		},
		isActive: {
		  type: DataTypes.INTEGER(11),
		  allowNull: true
		}
	  }, {
		sequelize,
		tableName: 'User',
		timestamps: false,
	  })
}

