async function checkTokenKey({tokenKey, email, sequelize}) {
    const User = await require('../models/user')(sequelize)
    const foundUser = await User.findOne({email, tokenKey})   
    debugger
    if(!foundUser) return false

}
module.exports = {
    checkTokenKey
}