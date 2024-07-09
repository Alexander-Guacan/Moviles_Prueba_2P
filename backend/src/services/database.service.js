import mongoose from "mongoose";

export class DatabaseService {
    static connect() {
        mongoose.connect("mongodb://localhost:27017/flutterbd").
            then(response => {
                console.log("Mongo connected");
            })
            .catch(error => {
                console.log(error);
            });
    }
}