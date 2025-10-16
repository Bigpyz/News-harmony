package service

import (
	"backend/model"
	"github.com/gin-gonic/gin"
	"net/http"
)

type LoginReq struct {
	Username string `json:"username" binding:"required"`
	Password string `json:"password" binding:"required"`
}

func Login(c *gin.Context) {
	var loginReq LoginReq
	if err := c.ShouldBindJSON(&loginReq); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	db := model.GormDB()
	var user model.User
	db.Where("username = ?", loginReq.Username).First(&user)
	if user.Password != loginReq.Password {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "wrong password"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"user": user})
}
