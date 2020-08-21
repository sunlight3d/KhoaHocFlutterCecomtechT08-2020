const { DataTypes, Sequelize } = require('sequelize');
//sequelize-auto -o "./models1" -h localhost -u root -p 3306 -x "" -e mysql -d NodejsBackend
module.exports = async (sequelize) => {	
	return sequelize.define('Product', {
        id: {
          autoIncrement: true,
          type: DataTypes.INTEGER(11),
          allowNull: false,
          primaryKey: true
        },
        name: {
          type: DataTypes.STRING(400),
          allowNull: false,
          unique: true
        },
        url: {
          type: DataTypes.STRING(400),
          allowNull: true
        },
        year: {
          type: DataTypes.INTEGER(11),
          allowNull: true,
          defaultValue: 2000
        },
        price: {
          type: DataTypes.FLOAT,
          allowNull: true,
          defaultValue: 0
        },
        quantity: {
          type: DataTypes.INTEGER(11),
          allowNull: true,
          defaultValue: 0
        }
      }, {
        sequelize,
        tableName: 'Product',
        timestamps: false,
      });
}

