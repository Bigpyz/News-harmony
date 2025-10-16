package main

import (
	"backend/model"
	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	db := model.InitDB()

	sqlDB, err := db.DB()
	if err != nil {
		panic("底层数据库连接失败：" + err.Error())
	}
	defer sqlDB.Close()

	router.Router(r)

	r.Run(":8080")
}
