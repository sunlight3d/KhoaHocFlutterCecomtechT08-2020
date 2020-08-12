const bcrypt = require('bcrypt')
const saltRounds = 10
async function hashPassword(password) {
    try {
        const hashedPassword  = await bcrypt.hash(password, saltRounds)
        return hashPassword
    }catch(exception) {
        return ''
    }
}
async function checkPassword({password, hashedPassword}) {     
    const match = await bcrypt.compare(password, hashPassword);
    return match
}

const generateRandomString = (length) => cryptoRandomString({length, type: 'base64'})

module.exports = {
    hashPassword,
    checkPassword,
    generateRandomString
}