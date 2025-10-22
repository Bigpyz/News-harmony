package service

import (
	"backend/model"
	"github.com/gin-gonic/gin"
	"net/http"
	"strconv"
)

func GetHotData(c *gin.Context) {
	db := model.GormDB()
	pageStr := c.DefaultQuery("page", "1")
	page, _ := strconv.Atoi(pageStr)
	if page < 1 {
		page = 1
	}

	pageSize := 7
	offset := (page - 1) * pageSize

	var data []model.HotData
	result := db.Limit(pageSize).Offset(offset).Find(&data)
	if result.Error != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"code":    500,
			"message": result.Error.Error(),
		})
		return
	}

	c.JSON(http.StatusOK, gin.H{
		"code":    200,
		"message": "success",
		"data":    data,
	})
}
