package router

import (
	"backend/service"
	"github.com/gin-gonic/gin"
)

func Router(r *gin.Engine) {
	r.POST("/register", service.Register)
	r.POST("/login", service.Login)
	r.GET("/userInfo", service.UserInfo)
	r.GET("/works", service.Works)
}
