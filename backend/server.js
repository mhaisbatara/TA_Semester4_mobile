const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');

const app = express();

// =======================
// 🔥 MIDDLEWARE
// =======================
app.use(express.json());

// ✅ CORS FIX (biar bisa di Chrome & Emulator)
app.use(cors({
  origin: "*",
  methods: ["GET", "POST", "PUT", "DELETE"],
  allowedHeaders: ["Content-Type"]
}));

// tambahan header manual (biar makin aman)
app.use((req, res, next) => {
  res.header("Access-Control-Allow-Origin", "*");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

// =======================
// 🔗 KONEKSI MONGODB
// =======================
mongoose.connect('mongodb://127.0.0.1:27017/db_obesitas_workout')
  .then(() => console.log('✅ MongoDB Connected'))
  .catch(err => console.log('❌ MongoDB Error:', err));
  
// =======================
// 📁 SCHEMA USER
// =======================
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

    // 🔥 ROLE VALIDATION
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
    console.error(err);
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
    console.error(err);
    res.status(500).json({ message: 'Server error' });
  }
});

// =======================
// 📊 GET USERS
// =======================
app.get('/users', async (req, res) => {
  try {
    const users = await User.find().select('-password');
    res.status(200).json(users);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
});

// =======================
// 🧪 TEST ROUTE (opsional)
// =======================
app.get('/', (req, res) => {
  res.send('API berjalan 🚀');
});

// =======================
// ▶️ RUN SERVER
// =======================
const PORT = 5000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`🚀 Server jalan di http://localhost:${PORT}`);
});