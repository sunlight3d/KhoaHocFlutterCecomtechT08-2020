module.exports = () => {
	const i18n = require("i18n")
	i18n.configure({
		locales:['en', 'vi'],
		defaultLocale: 'en',
		directory: './locales'
	})    
	return i18n
}

