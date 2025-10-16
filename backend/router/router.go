package router

import "github.com/gin-gonic/gin"

func Router(r *gin.Engine) {
	r.POST("/register", func(c *gin.Context) {})
	r.POST("/login", func(c *gin.Context) {})
	r.GET("/userInfo", func(c *gin.Context) {})
}
