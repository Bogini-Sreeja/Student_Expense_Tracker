const express = require("express");
const cors = require("cors");
const db = require("./db");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const app = express();

app.use(cors());
app.use(express.json());
const JWT_SECRET = "student_expense_tracker_secret";

// HOME ROUTE
app.get("/", (req, res) => {
  res.send("Backend Working 🚀");
});

// ================= REGISTER =================
app.post("/auth/register", async (req, res) => {
  const { name, email, password } = req.body;

  try {
    const hashedPassword = await bcrypt.hash(password, 10);

    db.query(
      "INSERT INTO users (name, email, password) VALUES (?, ?, ?)",
      [name, email, hashedPassword],
      (err) => {
        if (err) {
          return res.json({ error: err.message });
        }

        res.json({ message: "User Registered Successfully" });
      }
    );
  } catch (error) {
    res.json({ error: error.message });
  }
});

// ================= LOGIN =================
app.post("/auth/login", (req, res) => {
  const { email, password } = req.body;

  db.query(
    "SELECT * FROM users WHERE email = ?",
    [email],
    async (err, result) => {
      if (err) {
        return res.json({ error: err.message });
      }

      if (!result || result.length === 0) {
        return res.json({ message: "User not found" });
      }

      const user = result[0];

      const isMatch = await bcrypt.compare(
        password,
        user.password
      );

     if (!isMatch) {
  return res.json({ message: "Invalid password" });
}

const token = jwt.sign(
  {
    id: user.id,
    email: user.email
  },
  JWT_SECRET,
  { expiresIn: "7d" }
);

res.json({
  message: "Login successful",
  token: token,
  user: {
    id: user.id,
    name: user.name,
    email: user.email
  }
});
    }
  );
});

// ================= ADD EXPENSE =================
app.post("/expenses/add", (req, res) => {
  const { user_id, title, amount, category, expense_date } = req.body;

  db.query(
    "INSERT INTO expenses (user_id, title, amount, category, expense_date) VALUES (?, ?, ?, ?, ?)",
    [user_id, title, amount, category, expense_date],
    (err) => {
      if (err) {
        return res.json({ error: err.message });
      }

      res.json({ message: "Expense Added Successfully" });
    }
  );
});

// ================= GET USER EXPENSES =================
app.get("/expenses/:userId", verifyToken, (req, res) => {

  const userId = req.params.userId;

  db.query(
    "SELECT * FROM expenses WHERE user_id = ?",
    [userId],
    (err, result) => {

      if (err) {
        return res.json({ error: err.message });
      }

      res.json(result);
    }
  );
});

// ================= DELETE EXPENSE =================
app.delete("/expenses/:id", (req, res) => {
  const id = req.params.id;

  db.query(
    "DELETE FROM expenses WHERE id = ?",
    [id],
    (err) => {
      if (err) {
        return res.json({ error: err.message });
      }

      res.json({ message: "Expense Deleted Successfully" });
    }
  );
});
// ================= UPDATE EXPENSE =================
app.put("/expenses/:id", (req, res) => {

  const id = req.params.id;

  const { title, amount, category } = req.body;

  db.query(
    "UPDATE expenses SET title=?, amount=?, category=? WHERE id=?",
    [title, amount, category, id],
    (err, result) => {

      if (err) {
        return res.json({ error: err.message });
      }

      res.json({
        message: "Expense Updated Successfully"
      });
    }
  );
});
// ================= SET BUDGET =================
app.post("/budget", (req, res) => {

  const { user_id, amount } = req.body;

  db.query(
    "INSERT INTO budget (user_id, amount) VALUES (?, ?) ON DUPLICATE KEY UPDATE amount = ?",
    [user_id, amount,amount],
    (err, result) => {

      if (err) {
        return res.json({ error: err.message });
      }

      res.json({
        message: "Budget Saved Successfully"
      });

    }
  );
});
// ================= GET BUDGET =================
app.get("/budget/:userId", (req, res) => {

  const userId = req.params.userId;

  db.query(
    "SELECT * FROM budget WHERE user_id = ? ORDER BY id DESC LIMIT 1",
    [userId],
    (err, result) => {

      if (err) {
        return res.json({ error: err.message });
      }

      if (result.length === 0) {
        return res.json({
          amount: 0
        });
      }

      res.json(result[0]);

    }
  );
});
function verifyToken(req, res, next) {

  const token = req.headers.authorization;

  if (!token) {
    return res.status(401).json({
      message: "Access Denied"
    });
  }

  try {

    const verified = jwt.verify(
      token,
      JWT_SECRET
    );

    req.user = verified;

    next();

  } catch (err) {

    res.status(400).json({
      message: "Invalid Token"
    });

  }
}
// ================= START SERVER =================
app.listen(5000, () => {
  console.log("Server running on port 5000");
});