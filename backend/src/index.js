import express, { json } from "express"
import cors from "cors"
import { userRoute } from "./routes/user.routes.js"
import { DatabaseService } from "./services/database.service.js"

const PORT = 3000
const app = express()

app.use(cors())
app.use(json())
app.use(userRoute)

function main() {
    DatabaseService.connect()

    app.listen(PORT, () => {
        console.log(`Init on port ${PORT}`)
    })
}

main()