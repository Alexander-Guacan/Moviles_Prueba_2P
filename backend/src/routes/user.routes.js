import { Router } from "express"
import { UserController } from "../controllers/user.controller.js"

export const userRoute = Router()

userRoute.get("/users", UserController.getUsers)
userRoute.get("/users/:id", UserController.getUserById)
// userRoute.get("/users/create", UserController.createFakeUsers);
userRoute.post("/users", UserController.postUser)
userRoute.delete("/users/:id", UserController.deleteUser)
userRoute.put("/users/:id", UserController.updateUser)