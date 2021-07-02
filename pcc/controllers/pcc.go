// @author  dreamlu
package controllers

import (
	"demo/models"
	"github.com/gin-gonic/gin"
	"net/http"
)

//根据id获得用户获取
func GetList(u *gin.Context) {
	ss := models.GetList()
	u.JSON(http.StatusOK, ss)
}
//
////用户信息分页
//func GetBySearch(u *gin.Context) {
//	_ = u.Request.ParseForm()
//	values := u.Request.Form //在使用之前需要调用ParseForm方法
//	xss.XssMap(values)
//	ss := p.GetBySearch(values)
//	u.JSON(http.StatusOK, ss)
//}
//
////用户信息删除
//func Delete(u *gin.Context) {
//	id := u.Param("id")
//	ss := p.Delete(id)
//	u.JSON(http.StatusOK, ss)
//}
//
////用户信息修改
//func Update(u *gin.Context) {
//	_ = u.Request.ParseForm()
//	values := u.Request.Form
//	xss.XssMap(values)
//
//	ss := p.Update(values)
//	u.JSON(http.StatusOK, ss)
//}
//
////新增用户信息
//func Create(u *gin.Context) {
//	_ = u.Request.ParseForm()
//	values := u.Request.Form
//	xss.XssMap(values)                            //html特殊字符转换
//	res := validator.Valid(values, models.User{}) //验证规则
//	if res != lib.MapValSuccess {
//		u.JSON(http.StatusOK, res)
//		return
//	}
//
//	ss := p.Create(values)
//	u.JSON(http.StatusOK, ss)
//}
