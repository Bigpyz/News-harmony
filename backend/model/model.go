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
