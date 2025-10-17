package model

import (
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
)

var gormDB *gorm.DB

func InitDB() *gorm.DB {
	db, err := gorm.Open(sqlite.Open("./test.db"), &gorm.Config{})
	if err != nil {
		panic("连接数据库失败: " + err.Error())
	}

	db.AutoMigrate(&User{})
	db.AutoMigrate(&Work{})

	gormDB = db
	return db
}

func GormDB() *gorm.DB {
	return gormDB
}
