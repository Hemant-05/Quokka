import jwt from 'jsonwebtoken';

const JWT_SECRET = process.env.JWT_SECRET || 'superSecretKey123';

const generateToken = (id: string) => {
  return jwt.sign({ id }, JWT_SECRET, { expiresIn: '7d' });
};

const verifyToken = (token: string) => {
  return jwt.verify(token, JWT_SECRET) as { id: string };
};

export default { generateToken, verifyToken };
