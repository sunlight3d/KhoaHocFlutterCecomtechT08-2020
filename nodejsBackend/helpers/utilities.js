const bcrypt = require('bcrypt')
const cryptoRandomString = require('crypto-random-string')
const saltRounds = 10
async function hashPassword(password) {
    try {
        return await bcrypt.hash(password, saltRounds)        
    }catch(exception) {
        return ''
    }
}
async function checkPassword({password, hashedPassword}) {     
    const match = await bcrypt.compare(password, hashedPassword);
    return match
}

const generateRandomString = (length) => cryptoRandomString({length, type: 'base64'})

module.exports = {
    hashPassword,
    checkPassword,
    generateRandomString
}