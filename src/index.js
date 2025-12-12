import express from "express";

const app = express();

app.get("/message", (req, res) => {
    const date = new Date();
    const vnTime = date.toLocaleString('vi-VN', { timeZone: 'Asia/Ho_Chi_Minh' });
    res.json({ message: `Hello World 2: ${vnTime}` });
});

app.listen(3000, () => {
    console.log("Server is running on port 3000");
});