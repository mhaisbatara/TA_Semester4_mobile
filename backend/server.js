const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');

const app = express();
app.use(express.json());
app.use(cors());

// 🔗 koneksi MongoDB
mongoose.connect('mongodb://127.0.0.1:27017/db_obesitas_workout')
  .then(() => console.log('MongoDB Connected'))
  .catch(err => console.log(err));

// 📁 schema user
const UserSchema = new mongoose.Schema({
  name: String,
  email: String,
  password: String,
  role: String
});

const User = mongoose.model('User', UserSchema);

// 🔐 LOGIN
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });

  if (!user) {
    return res.status(400).json({ message: 'User tidak ditemukan' });
  }

  const isMatch = await bcrypt.compare(password, user.password);

  if (!isMatch) {
    return res.status(400).json({ message: 'Password salah' });
  }

  // 🔥 VALIDASI ROLE
  if (user.role !== 'user') {
    return res.status(403).json({ message: 'Hanya user yang boleh login' });
  }

  res.json({
    message: 'Login berhasil',
    user: {
      name: user.name,
      email: user.email,
      role: user.role
    }
  });
});

// 📝 REGISTER
app.post('/register', async (req, res) => {
  const { name, email, password } = req.body;

  try {
    // cek email sudah ada atau belum
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: 'Email sudah terdaftar' });
    }

    // hash password
    const hashedPassword = await bcrypt.hash(password, 10);

    // simpan user baru (role otomatis user)
    const newUser = new User({
      name,
      email,
      password: hashedPassword,
      role: 'user'
    });

    await newUser.save();

    res.json({ message: 'Registrasi berhasil' });

  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
});

// ▶️ RUN SERVER
app.listen(5000, () => {
  console.log('Server jalan di http://localhost:5000');
});