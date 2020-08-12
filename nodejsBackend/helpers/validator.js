const Validator = require('validatorjs')
module.exports = (body, rules) => {
    const validation = new Validator(body, rules, {})
    validation.passes(() => callback(null, true))
    validation.fails(() => callback(validation.errors, false))
}
