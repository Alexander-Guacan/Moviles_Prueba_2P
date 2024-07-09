import { Schema, model } from "mongoose";

const UserSchema = new Schema({
    firstname: {
        type: String,
        require: true
    },
    lastname: {
        type: String,
        require: true
    },
    avatar: {
        type: String,
        require: true
    }
});

export const UserModel = model('User', UserSchema);