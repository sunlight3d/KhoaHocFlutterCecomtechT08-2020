const Validator = require('validatorjs')
module.exports = async (body, rules) => {
    const validation = new Validator(body, rules, {})        
    return new Promise((resolve, reject) => {
        validation.passes(() => resolve({error: null, status: true}))
        validation.fails(() => reject({error: validation.errors, status: false}))
    })    
}
