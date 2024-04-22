const app = require("./app");
const db = require('./Config/db');
const userModel = require('./Models/user.model');

const port = 3000;

app.get(`/`, (req, res) => {
    res.send('Assessment using Gidy.ai');
})

app.listen(port, () => {
    console.log(`server listening on port http://localhost:${port}`);//check server connection
})