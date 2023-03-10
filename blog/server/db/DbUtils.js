const mysql = require('mysql')
const GenId = require("../utils/SnowFlake")

const db = mysql.createPool({
    //连接主机名或IP地址
    host: '127.0.0.1',
    //用户名
    user: 'root',
    //用户密码
    password: '123456',
    //连接的数据库名
    database: 'blog'
})

const genid = new GenId({ WorkerId: 1 })


db.async = {}



db.async.query = (sql, param) => {
    return new Promise((resolve, reject) => {
        db.query(sql, param, (err, rows) => {
            resolve({ err, rows })
        })
    })
}

module.exports = { db, genid }
