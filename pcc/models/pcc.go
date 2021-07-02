package models

import (
	der "github.com/dreamlu/go-tool"
	"github.com/dreamlu/go-tool/util/lib"
)

// 省份
type Province struct {
	ID   int64  `json:"id"`
	Code string `json:"code"` // 编号
	Name string `json:"name"` // 名称
	AZ   string `json:"az"`   // 首字母
	City []*City `json:"city"`
}

// 城市
type City struct {
	ID         int64  `json:"id"`
	Code       string `json:"code"` // 编号
	Name       string `json:"name"` // 名称
	AZ         string `json:"az"`   // 首字母
	ProvinceID int64  `json:"province_id"`
	Area       []*Area `json:"area"`
}

// 区县
type Area struct {
	ID     int64  `json:"id"`
	Code   string `json:"code"` // 编号
	Name   string `json:"name"` // 名称
	AZ     string `json:"az"`   // 首字母
	CityID int64  `json:"city_id"`
}

// 获取所有
func GetList() interface{} {
	var province []*Province
	der.DB.Find(&province)
	// city
	for _,p := range province{
		der.DB.Where("province_id = ?", p.ID).Find(&p.City)
		for _,c := range p.City {
			der.DB.Where("city_id = ?", c.ID).Find(&c.Area)
		}
	}

	return lib.GetMapDataSuccess(province)
}
