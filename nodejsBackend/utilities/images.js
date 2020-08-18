module.exports = async ({files}) => {
    //output : array of image names
    return new Promise((resolve, reject) => {
        const keys = Object.keys(files)
        if (keys.length === 0) {            
            resolve({result: [], error: null})
        }
        let imageNames = []
        keys.forEach(async (key) => {
            const fileName = `${Math.random().toString(64)}`
            const fileObject = await req.files[key]
            const fileExtension = fileObject.name.split('.').pop()
            const destination = `${path.join(__dirname, '..')}/uploads/${fileName}.${fileExtension}`
            let error = await fileObject.mv(destination) //mv = move 
            reject({result: [], error})            
            imageNames.push(`${fileName}.${fileExtension}`)            
            if (key === keys[keys.length - 1]) {
                resolve({result: imageNames, error: null})
            }
        })
    })    
}