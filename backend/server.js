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
}, { timestamps: true });

const User = mongoose.model('User', UserSchema);

// =======================
// 🔐 LOGIN
// =======================
app.post('/login', async (req, res) => {
  try {
    const { email, password } = req.body;

    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({ message: 'User tidak ditemukan' });
    }

    const isMatch = await bcrypt.compare(password, user.password);

    if (!isMatch) {
      return res.status(400).json({ message: 'Password salah' });
    }

    if (user.role !== 'user') {
      return res.status(403).json({ message: 'Hanya user yang boleh login' });
    }

    res.json({
      message: 'Login berhasil',
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        role: user.role
      }
    });

  } catch (err) {
    res.status(500).json({ message: 'Server error' });
  }
});

// =======================
// 📝 REGISTER
// =======================
app.post('/register', async (req, res) => {
  try {
    const { name, email, password } = req.body;

    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res.status(400).json({ message: 'Email sudah terdaftar' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

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

// =======================
// 📊 GET ALL USERS (INI YANG KAMU BUTUH)
// =======================
app.get('/users', async (req, res) => {
  try {
    const users = await User.find().select('-password'); // password disembunyikan
    res.status(200).json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// =======================
// ▶️ RUN SERVER
// =======================
app.listen(5000, () => {
  console.log('Server jalan di http://localhost:5000');
});