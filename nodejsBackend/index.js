/*
npm install -i express express-fileupload firebase firebase-admin googleapi googleapis 
npm install -i http i18n mysql mysql2 json-parser readline-sync sequelize sequelize-auto tedious
*/

const { HOSTNAME, MAXMUM_FILE_SIZE} = require('./constants/constants')
const app = require('express')()
const app = express()
const i18n = require('./locales/i18n')()
app.use(i18n.init);
const bodyParser = require('body-parser')
const fileUpload = require('express-fileupload')
app.use(bodyParser.urlencoded({ extended: false }))
app.use(bodyParser.json())
app.use(fileUpload({
    limits: { fileSize: MAXMUM_FILE_SIZE * 1024 * 1024 },  //Maximum = 50 MB  
}))
const sequelize = require('./database/database')()
const router = express.Router()
const userRouter = require('./routings/user')

app.use('/users', userRouter({router, i18n, sequelize}))
app.use('/categories', userRouter({router, i18n, sequelize}))
app.use('/products', userRouter({router, i18n, sequelize}))
app.use('/orders', userRouter({router, i18n, sequelize}))

const PORT = 3000
app.listen(PORT, () => {
    console.log(`Server listen from : ${PORT}`)    
})









