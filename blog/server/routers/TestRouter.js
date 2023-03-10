const express = require("express")
const router = express.Router()
const { db, genid } = require("../db/DbUtils")

router.get("/test", async (req, res) => {
    // db.query("select * from `admin`",[],(err, rows) => {
    //     console.log(rows);
    // })

    let out = await db.async.query("select * from `admin`",[])

    res.send({
        id: genid.NextId(),
        out //相当于 out:out
    })
})

module.exports = router