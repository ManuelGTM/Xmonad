package main

import (
	"github.com/labstack/echo/v4"
	"net/http"
)

func getUser(c echo.Context) error {
	id := c.Param("id")
	return c.String(http.StatusOK, id)
}

func show(c echo.Context) error {
	team := c.QueryParam("team")
	member := c.QueryParam("member")
	return c.String(http.StatusOK, "{team: "+team+", member: "+member+"}")
}

func save(c echo.Context) error {
	name := c.FormValue("name")
	email := c.FormValue("email")
	return c.String(http.StatusOK, "name: "+name+", email: "+email)
}

func post(c echo.Context) error {
	name := c.FormValue("name")
	return c.String(http.StatusOK, "My name is:"+name)
}

func main() {

	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "This is my first backend!")
	})

	//Routing

	// e.Post("/users", saveUser)
	e.GET("users/:id", getUser)
	e.GET("/show/show", show)
	e.POST("/save/", save)
	e.POST("/post/", post)
	// e.PUT("/users/:id", updateUser)
	// e.DELETE("/users", deleteUSer)

	e.Logger.Fatal(e.Start(":1323"))
}
