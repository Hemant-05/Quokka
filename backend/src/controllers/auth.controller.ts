import { Request, Response } from 'express';
import jwt from '../utils/jwt';
import prisma from '../config/prisma';
import bcrypt from 'bcrypt';


export const register = async (req: Request, res: Response) => {
  const { username, email, password } = req.body;

  try {
    const existingMail = await prisma.user.findUnique({ where: { email } });
    if (existingMail) return res.status(400).json({ message: 'Email already registered' });
    const existingUserName = await prisma.user.findUnique({
      where: { username },
    });

    if (existingUserName) {
      return res.status(400).json({ error: 'Username already taken' });
    }

    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await prisma.user.create({
      data: {
        username,
        email,
        password: hashedPassword,
      },
    });

    const token = jwt.generateToken(user.id);
    res.status(201).json({ user: { id: user.id, email: user.email, username: user.username }, token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Registration failed', error: err.message });
  }
};

export const login = async (req: Request, res: Response) => {
  const { email, password } = req.body;

  try {
    const user = await prisma.user.findUnique({ where: { email } });
    if (!user) return res.status(400).json({ message: 'Invalid credentials' });

    const isMatch = await bcrypt.compare(password, user.password);
    if (!isMatch) return res.status(400).json({ message: 'Invalid credentials' });

    const token = jwt.generateToken(user.id);
    res.status(200).json({ user: { id: user.id, email: user.email, username: user.username }, token });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: 'Login failed', error: err.message });
  }
};

