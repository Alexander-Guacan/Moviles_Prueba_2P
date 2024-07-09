import { UserModel } from "../models/user.model.js"
import { fa, faker } from "@faker-js/faker"
import { DatabaseService } from "../services/database.service.js"

export class UserController {
    /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async getUsers(_, response) {
        const users = await UserModel.find()
        response.json(users)
    }

     /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async getUserById(request, response) {
        const { id } = request.params
        const user = await UserModel.findById(id)
        response.json(user)
    }

    /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async createFakeUsers(_, response) {
        let users = []
        let errorMessage = ""

        for (let i = 0; i < 5; ++i) {
            try {
                let response = await UserModel.create({
                    firstname: faker.person.firstName(),
                    lastname: faker.person.lastName(),
                    avatar: faker.image.avatar()
                })

                users.push(response)
            } catch (error) {
                errorMessage += `User ${i} can't be created\n`
            }
        }

        response.json({
            users: users,
            message: errorMessage.length ? errorMessage : "Users created successfully"
        })
    }

    /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async postUser(request, response) {
        const user = request.body
        const userCreated = await UserModel.create({
            ...user,
            avatar: faker.image.avatarGitHub()
        })
        response.json(userCreated)
    }

    /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async deleteUser(request, response) {
        const { id } = request.params
        const userDeleted = await UserModel.findByIdAndDelete(id)
        response.json(userDeleted)
    }

    /**
     * 
     * @param {import("express").Request} request 
     * @param {import("express").Response} response 
     * @returns 
     */
    static async updateUser(request, response) {
        const { id } = request.params
        const user = request.body
        const userUptated = await UserModel.findByIdAndUpdate(id, user)
        response.json(userUptated)
    }
}