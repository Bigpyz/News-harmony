package service

import (
	"backend/model"
	"github.com/gin-gonic/gin"
	"net/http"
)

type WorksReq struct {
	Username string `json:"username" binding:"required"`
}

func Works(c *gin.Context) {
	var req WorksReq
	if err := c.ShouldBindJSON(&req); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}
	db := model.GormDB()
	var works []model.Work
	db.Where("username = ?", req.Username).Find(&works)
	c.JSON(http.StatusOK, gin.H{"works": works})
}
