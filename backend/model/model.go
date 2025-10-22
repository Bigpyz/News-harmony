package model

type User struct {
	Username  string `json:"username"`
	Password  string `json:"password"`
	Follow    int    `json:"follow"`
	Fans      int    `json:"fans"`
	Likes     int    `json:"likes"`
	Signature string `json:"signature"`
}

type Work struct {
	Username string `json:"username"`
	Data     string `json:"data"`
	Content  string `json:"content"`
}

type HotData struct {
	ID      uint   `gorm:"primaryKey" json:"-"`
	Index   int    `gorm:"column:idx" json:"index"`
	Text    string `json:"text"`
	BgColor string `json:"bgColor"`
	Color   string `json:"color"`
	Content string `json:"content"`
	Source  string `json:"source"`
	Icon    string `json:"icon"`
	HotWord string `json:"hotWord"`
	Image   string `json:"image"`
}

func (*HotData) TableName() string {
	return "hot_data"
}
