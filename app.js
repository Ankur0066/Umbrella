const express = require('express');
const multer = require('multer');
const path = require('path');
const app = express();

// Multer storage configuration
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage });

app.use(express.static('public'));
app.use('/uploads', express.static('uploads'));

app.get("/",(req,res)=>{
    res.render("home.ejs")
})
app.post('/', upload.single('upload[IMAGE]'), (req, res) => {
  if (!req.file) {
    return res.status(400).send('No file uploaded.');
  }
  
  // Return the path to the uploaded image
  res.json({ imagePath: `/uploads/${req.file.filename}` });
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
