package service

import (
	"backend/model"
	"github.com/gin-gonic/gin"
	"net/http"
)

type UserInfoReq struct {
	Username string `json:"username" binding:"required"`
}

func UserInfo(c *gin.Context) {
	var req UserInfoReq
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	db := model.GormDB()
	var user model.User
	db.Where("username = ?", req.Username).First(&user)

	c.JSON(http.StatusOK, gin.H{"user": user})
}
